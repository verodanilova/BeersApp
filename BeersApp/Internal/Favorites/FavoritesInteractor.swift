//
//  FavoritesInteractor.swift
//  BeersApp
//
//  Created by Veronica Danilova on 08.11.2020.
//

import Foundation
import RxSwift
import RxCocoa
import BeersCore


protocol FavoritesInteractorType {
    var listItems: Driver<[BeerListItem]> {get}
    var currentBeerInfos: [BeerInfo] {get}
    
    func removeItemFromStorage(with id: Int)
}

final class FavoritesInteractor: FavoritesInteractorType {
    typealias Context = FavoriteBeersStorageContext & BeersDataSourceContext
    
    let listItems: Driver<[BeerListItem]>
    private let listItemsRelay = BehaviorRelay<[BeerListItem]>(value: [])
    
    var currentBeerInfos: [BeerInfo] {
        return beersFRC?.currentItem ?? []
    }
    
    private let context: Context
    private var beersFRC: MultiFetchedResultsControllerDelegate<BeerInfo>?
    private let favoriteStorage: FavoriteBeersStorageType
    private let disposeBag = DisposeBag()
    private var frcDisposeBag = DisposeBag()
    
    init(context: Context) {
        self.context = context
        self.favoriteStorage = context.favoriteBeersStorage
        self.listItems = listItemsRelay.asDriver()

        favoriteStorage.favoriteBeerIDs
            .drive(onNext: configureBeersFRC)
            .disposed(by: disposeBag)
    }
    
    func removeItemFromStorage(with id: Int) {
        favoriteStorage.remove(favoriteBeerID: id)
    }
}

// MARK: - Data configuration
private extension FavoritesInteractor {
    func configureBeersFRC(for favoriteBeerIDs: Set<Int>) {
        frcDisposeBag = DisposeBag()
        
        self.beersFRC = context.beersDataSource.makeBeersFRC(withIDs: favoriteBeerIDs)
        beersFRC?.fetchedItem
            .map(makeBeerItemsList)
            .drive(listItemsRelay)
            .disposed(by: frcDisposeBag)
    }
    
    func makeBeerItemsList(infos: [BeerInfo]) -> [BeerListItem] {
        infos.map { BeerListItem(beerInfo: $0) }
    }
}
