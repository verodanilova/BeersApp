//
//  BeersListViewModel.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import Foundation
import RxSwift
import RxCocoa


protocol BeersListViewModelType {
    var items: Driver<[BeersListItemViewModelType]> {get}
    var isInActivity: Driver<Bool> {get}
    
    func bindViewEvents(itemSelected: Signal<IndexPath>,
        itemAddedToFavorites: Signal<IndexPath>, sortTap: Signal<Void>)
    func prepare()
    func loadMoreData()
    func swipeActionTitle(at indexPath: IndexPath) -> String
}

final class BeersListViewModel: BeersListViewModelType {
    typealias Context = NavigatorContext & BeersListInteractor.Context
    
    let items: Driver<[BeersListItemViewModelType]>
    private let itemsRelay = BehaviorRelay<[BeersListItemViewModelType]>(value: [])
    
    let isInActivity: Driver<Bool>
    
    private let context: Context
    private let interactor: BeersListInteractorType
    private let storage: BeerFiltersStorageType
    private var filtersModel: BeerFiltersBottomSheetViewModelType?
    private let disposeBag = DisposeBag()
    
    init(context: Context) {
        self.context = context
        self.interactor = BeersListInteractor(context: context)
        self.storage = BeerFiltersStorage()
        self.items = itemsRelay.asDriver()
        self.isInActivity = interactor.isInActivity
        self.filtersModel = BeerFiltersBottomSheetViewModel(storage: storage, delegate: self)
        
        interactor.listItems
            .map { $0.map { BeersListItemViewModel(item: $0) } }
            .drive(itemsRelay)
            .disposed(by: disposeBag)
    }
    
    func bindViewEvents(itemSelected: Signal<IndexPath>,
        itemAddedToFavorites: Signal<IndexPath>, sortTap: Signal<Void>) {
        itemSelected
            .emit(onNext: weakly(self, type(of: self).itemSelected))
            .disposed(by: disposeBag)
        
        itemAddedToFavorites
            .emit(onNext: weakly(self, type(of: self).itemAddedToFavorites))
            .disposed(by: disposeBag)
        
        sortTap
            .emit(onNext: weakly(self, type(of: self).showSortOptions))
            .disposed(by: disposeBag)
    }
    
    func prepare() {
        interactor.loadBeersListIfNeeded()
    }
    
    func loadMoreData() {
        interactor.loadMoreData()
    }
    
    func swipeActionTitle(at indexPath: IndexPath) -> String {
        let id = interactor.currentBeerInfos[indexPath.item].id
        let isFavoriteItem = interactor.isFavoriteItem(beerID: Int(id))
        if isFavoriteItem {
            return NSLocalizedString(
                "Beers list.Swipe action.Remove from favorite.Title",
                comment: "Beers list: title for unfavorite swipe action")
        } else {
            return NSLocalizedString(
                "Beers list.Swipe action.Add to favorite.Title",
                comment: "Beers list: title for add to favorites swipe action")
        }
    }
}

// MARK: - Navigation & Actions
private extension BeersListViewModel {
    func itemSelected(at indexPath: IndexPath) {
        let id = interactor.currentBeerInfos[indexPath.item].id
        context.navigator.navigate(to: .beerDetails(id: Int(id)), in: .list)
    }
    
    func itemAddedToFavorites(at indexPath: IndexPath) {
        let id = interactor.currentBeerInfos[indexPath.item].id
        interactor.updateFavoriteBeersStorage(with: Int(id))
    }
    
    func showSortOptions() {
        guard let model = filtersModel else { return }
        context.navigator.navigate(to: .beerFiltersBottomSheet(model: model), in: .list)
    }
}

// MARK: - BeerFiltersBottomSheetDelegate conformance
extension BeersListViewModel: BeerFiltersBottomSheetDelegate {
    func shouldApplyFilters() {
        if storage.hasSelectedFilters {
            interactor.loadBeersListWithFilters(storage: storage)
        }
    }
}
