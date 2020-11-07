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
    
    func bindViewEvents(itemSelected: Signal<IndexPath>, sortTap: Signal<Void>)
    func prepare()
    func loadMoreData()
}

final class BeersListViewModel: BeersListViewModelType {
    typealias Context = NavigatorContext & BeersAPIContext & DataContext
    
    let items: Driver<[BeersListItemViewModelType]>
    private let itemsRelay = BehaviorRelay<[BeersListItemViewModelType]>(value: [])
    
    let isInActivity: Driver<Bool>
    private let isLoadingInProgressRelay = BehaviorRelay<Bool>(value: false)
    
    private let context: Context
    private let dataSource: BeersDataSourceType
    private let beersFRC: MultiFetchedResultsControllerDelegate<BeerInfo>
    private let disposeBag = DisposeBag()
    
    init(context: Context) {
        self.context = context
        self.dataSource = BeersDataSource(context: context)
        self.beersFRC = dataSource.makeBaseBeersFRC()
        self.items = itemsRelay.asDriver()
        self.isInActivity = isLoadingInProgressRelay.asDriver()

        beersFRC.fetchedItem
            .map { $0.map { BeersListItemViewModel(item: $0) } }
            .drive(itemsRelay)
            .disposed(by: disposeBag)
    }
    
    func bindViewEvents(itemSelected: Signal<IndexPath>, sortTap: Signal<Void>) {
        itemSelected
            .emit(onNext: weakly(self, type(of: self).itemSelected))
            .disposed(by: disposeBag)
        
        sortTap
            .emit(onNext: weakly(self, type(of: self).showSortOptions))
            .disposed(by: disposeBag)
    }
    
    func prepare() {
        if beersFRC.currentItem.isEmpty {
            loadBeersList()
        }
    }
    
    func loadMoreData() {
        guard !isLoadingInProgressRelay.value else { return }
        
        let itemsCount = beersFRC.currentItem.count
        let dataFetchLimit = appConfiguration.dataFetchLimit
        let loadingPage = (itemsCount / dataFetchLimit) + 1
        
        loadBeersList(loadingPage)
    }
}

// MARK: - Data loading
private extension BeersListViewModel {
    func loadBeersList(_ page: Int? = nil) {
        isLoadingInProgressRelay.accept(true)
        
        var request = GetBeersListRequest()
        if let loadingPage = page {
            request = GetBeersListRequest(page: loadingPage)
        }
        context.beersAPI.getBeersList(request)
            .subscribe(onSuccess: { [weak self] _ in
                self?.isLoadingInProgressRelay.accept(false)
            }, onError: { [weak self] error in
                self?.isLoadingInProgressRelay.accept(false)
                print("Error while loading beers list: \(error)")
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Navigation
private extension BeersListViewModel {
    func itemSelected(at indexPath: IndexPath) {
        // TODO: Add navigation to item screen
    }
    
    func showSortOptions() {
        // TODO: Add navigation to sort options
    }
}
