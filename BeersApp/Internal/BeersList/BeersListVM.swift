//
//  BeersListViewModel.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import Foundation
import RxSwift
import RxCocoa
import BeersCore


protocol BeersListViewModelType {
    var items: Driver<[BeerListItem]> {get}
    var isInActivity: Driver<Bool> {get}
    var headerFilters: Driver<HeaderFilters> {get}
    var errorOccurredSignal: Signal<Void> {get}
    
    func bindViewEvents(itemSelected: Signal<IndexPath>,
                        filtersTap: Signal<Void>,
                        resetFilterTap: Signal<FilterType>,
                        resetFiltersTap: Signal<Void>)
    func itemAddedToFavorites(_ index: Int)
    func prepare()
    func loadMoreData()
}

final class BeersListViewModel: BeersListViewModelType {
    typealias Context = NavigatorContext & BeersListInteractor.Context
    
    let items: Driver<[BeerListItem]>
    private let itemsRelay = BehaviorRelay<[BeerListItem]>(value: [])
    
    let isInActivity: Driver<Bool>
    let errorOccurredSignal: Signal<Void>
    
    let headerFilters: Driver<HeaderFilters>
    private let headerFiltersRelay = BehaviorRelay<HeaderFilters>(value: [:])
    
    private let context: Context
    private let interactor: BeersListInteractorType
    private let storage: BeerFiltersStorageType
    private let disposeBag = DisposeBag()
    
    init(context: Context) {
        self.context = context
        self.interactor = BeersListInteractor(context: context)
        self.storage = BeerFiltersStorage()
        self.items = itemsRelay.asDriver()
        self.isInActivity = interactor.isInActivity
        self.headerFilters = headerFiltersRelay.asDriver()
        self.errorOccurredSignal = interactor.errorOccurredSignal
        
        interactor.listItems
            .drive(itemsRelay)
            .disposed(by: disposeBag)
    }
    
    func bindViewEvents(itemSelected: Signal<IndexPath>,
        filtersTap: Signal<Void>, resetFilterTap: Signal<FilterType>,
        resetFiltersTap: Signal<Void>) {
        itemSelected
            .emit(onNext: weakly(self, type(of: self).itemSelected))
            .disposed(by: disposeBag)
        
        filtersTap
            .emit(onNext: weakly(self, type(of: self).showFilters))
            .disposed(by: disposeBag)
        
        resetFilterTap
            .emit(onNext: weakly(self, type(of: self).resetFilter))
            .disposed(by: disposeBag)
        
        resetFiltersTap
            .emit(onNext: weakly(self, type(of: self).resetFilters))
            .disposed(by: disposeBag)
    }
    
    func itemAddedToFavorites(_ index: Int) {
        let id = interactor.currentBeerInfos[index].id
        interactor.updateFavoriteBeersStorage(with: Int(id))
    }
    
    func prepare() {
        interactor.loadBeersListIfNeeded()
    }
    
    func loadMoreData() {
        interactor.loadMoreData()
    }
}

// MARK: - Navigation & Actions
private extension BeersListViewModel {
    func itemSelected(at indexPath: IndexPath) {
        let id = interactor.currentBeerInfos[indexPath.item].id
        context.navigator.navigate(to: .beerDetails(id: Int(id)), in: .list)
    }

    func showFilters() {
        let filtersModel = BeerFiltersBottomSheetViewModel(storage: storage, delegate: self)
        context.navigator.navigate(to: .beerFiltersBottomSheet(model: filtersModel), in: .list)
    }
    
    func resetFilter(_ filterType: FilterType) {
        storage.resetFilter(of: filterType)
        if storage.hasSelectedFilters {
            shouldApplyFilters()
        } else {
            resetFilters()
        }
    }
    
    func resetFilters() {
        storage.resetFilters()
        interactor.resetFilters()
        headerFiltersRelay.accept([:])
    }
}

// MARK: - BeerFiltersBottomSheetDelegate conformance
extension BeersListViewModel: BeerFiltersBottomSheetDelegate {
    func shouldApplyFilters() {
        if storage.hasSelectedFilters {
            interactor.loadBeersListWithFilters(storage: storage)
            headerFiltersRelay.accept(makeHeaderFilters(from: storage))
        }
    }
    
    private func makeHeaderFilters(from storage: BeerFiltersStorageType) -> HeaderFilters {
        let configurator = HeaderFiltersConfigurator(storage: storage)
        var filters: HeaderFilters = [:]
        
        if configurator.hasAlcoholFilter {
            let format = NSLocalizedString(
                "Beers list.Header.Filters.Alcohol.Format",
                comment: "Beers list filters header: alcohol value format")
            filters[.alcohol] = String(format: format, configurator.alcoholValue)
        }
        
        if configurator.hasBitternessFilter {
            let format = NSLocalizedString(
                "Beers list.Header.Filters.Bitterness.Format",
                comment: "Beers list filters header: bitterness value format")
            filters[.bitterness] = String(format: format, configurator.bitternessValue)
        }
        
        if configurator.hasColorFilter {
            filters[.color] = configurator.colorValue
        }
        
        return filters
    }
}
