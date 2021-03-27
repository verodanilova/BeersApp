//
//  FavoritesViewModel.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import Foundation
import RxSwift
import RxCocoa


protocol FavoritesViewModelType {
    var items: Driver<[BeerListItem]> {get}
    
    func bindViewEvents(itemSelected: Signal<IndexPath>)
}

final class FavoritesViewModel: FavoritesViewModelType {
    typealias Context = NavigatorContext & FavoritesInteractor.Context
    
    let items: Driver<[BeerListItem]>
    private let itemsRelay = BehaviorRelay<[BeerListItem]>(value: [])
    
    private let context: Context
    private let interactor: FavoritesInteractorType
    private let disposeBag = DisposeBag()
    
    init(context: Context) {
        self.context = context
        self.interactor = FavoritesInteractor(context: context)
        self.items = itemsRelay.asDriver()
        
        interactor.listItems
            .drive(itemsRelay)
            .disposed(by: disposeBag)
    }
    
    func bindViewEvents(itemSelected: Signal<IndexPath>) {
        itemSelected
            .emit(onNext: weakly(self, type(of: self).itemSelected))
            .disposed(by: disposeBag)
    }
}

// MARK: - Navigation & Actions
private extension FavoritesViewModel {
    func itemSelected(at indexPath: IndexPath) {
        let id = interactor.currentBeerInfos[indexPath.item].id
        context.navigator.navigate(to: .beerDetails(id: Int(id)), in: .favorites)
    }
}
