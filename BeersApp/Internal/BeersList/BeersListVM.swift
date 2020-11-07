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
    
    func bindViewEvents(itemSelected: Signal<IndexPath>, sortTap: Signal<Void>)
    func prepare()
}

final class BeersListViewModel: BeersListViewModelType {
    typealias Context = NavigatorContext & BeersAPIContext & DataContext
    
    let items: Driver<[BeersListItemViewModelType]>
    private let itemsRelay = BehaviorRelay<[BeersListItemViewModelType]>(value: [])
    
    private let context: Context
    private let dataSource: BeersDataSourceType
    private let beersFRC: MultiFetchedResultsControllerDelegate<BeerInfo>
    private let disposeBag = DisposeBag()
    
    init(context: Context) {
        self.context = context
        self.dataSource = BeersDataSource(context: context)
        self.beersFRC = dataSource.makeBaseBeersFRC()
        self.items = itemsRelay.asDriver()

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
        let request = GetBeersListRequest()
        context.beersAPI.getBeersList(request)
            .subscribe()
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
