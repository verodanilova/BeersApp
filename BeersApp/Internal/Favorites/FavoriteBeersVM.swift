//
//  FavoriteBeersViewModel.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import Foundation
import RxSwift
import RxCocoa


protocol FavoriteBeersViewModelType {
    var items: Driver<[BeersListItemViewModelType]> {get}
    
    func bindViewEvents(itemSelected: Signal<IndexPath>, itemDeleted: Signal<IndexPath>)
}

final class FavoriteBeersViewModel: FavoriteBeersViewModelType {
    typealias Context = NavigatorContext & FavoriteBeersInteractor.Context
    
    let items: Driver<[BeersListItemViewModelType]>
    private let itemsRelay = BehaviorRelay<[BeersListItemViewModelType]>(value: [])
    
    private let context: Context
    private let interactor: FavoriteBeersInteractorType
    private let disposeBag = DisposeBag()
    
    init(context: Context) {
        self.context = context
        self.interactor = FavoriteBeersInteractor(context: context)
        self.items = itemsRelay.asDriver()
        
        interactor.listItems
            .map { $0.map { BeersListItemViewModel(item: $0, showFavoriteIcons: false) } }
            .drive(itemsRelay)
            .disposed(by: disposeBag)
    }
    
    func bindViewEvents(itemSelected: Signal<IndexPath>, itemDeleted: Signal<IndexPath>) {
        itemSelected
            .emit(onNext: weakly(self, type(of: self).itemSelected))
            .disposed(by: disposeBag)
        
        itemDeleted
            .emit(onNext: weakly(self, type(of: self).itemRemovedFromFavorites))
            .disposed(by: disposeBag)
    }
}

// MARK: - Navigation & Actions
private extension FavoriteBeersViewModel {
    func itemSelected(at indexPath: IndexPath) {
        let id = interactor.currentBeerInfos[indexPath.item].id
        context.navigator.navigate(to: .beerDetails(id: Int(id)), in: .favorites)
    }
    
    func itemRemovedFromFavorites(at indexPath: IndexPath) {
        let id = interactor.currentBeerInfos[indexPath.item].id
        interactor.removeItemFromStorage(with: Int(id))
    }
}
