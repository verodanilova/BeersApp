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
}

final class BeersListViewModel: BeersListViewModelType {
    typealias Context = NavigatorContext
    
    let items: Driver<[BeersListItemViewModelType]>
    private let itemsRelay = BehaviorRelay<[BeersListItemViewModelType]>(value: [])
    
    private let context: Context
    private let disposeBag = DisposeBag()
    
    init(context: Context) {
        self.context = context
        self.items = itemsRelay.asDriver()
        
        // Temporary items for testing
        let items: [BeersListItem] = [
            BeersListItem(name: "Item 1", tagline: "Tagline 1", imageName: "beer_ic"),
            BeersListItem(name: "Item 2", tagline: "Tagline 2", imageName: "beer_ic"),
            BeersListItem(name: "Item 2 Long title", tagline: "Tagline 2 long long long long long long long long long long long long long long long long long long long long long long long long text tagline", imageName: "beer_ic"),
            BeersListItem(name: "Item 3", tagline: "Tagline 3", imageName: "beer_ic"),
            BeersListItem(name: "Item 4", tagline: "Tagline 4", imageName: "beer_ic"),
            BeersListItem(name: "Item 5", tagline: "Tagline Tagline Tagline Tagline Tagline Tagline Tagline 5", imageName: "beer_ic")
        ]
        let cellModels = items.map { BeersListItemViewModel(item: $0) }
        itemsRelay.accept(cellModels)
    }
    
    func bindViewEvents(itemSelected: Signal<IndexPath>, sortTap: Signal<Void>) {
        itemSelected
            .emit(onNext: weakly(self, type(of: self).itemSelected))
            .disposed(by: disposeBag)
        
        sortTap
            .emit(onNext: weakly(self, type(of: self).showSortOptions))
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
