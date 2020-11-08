//
//  BeersListInteractor.swift
//  BeersApp
//
//  Created by Veronica Danilova on 08.11.2020.
//

import Foundation
import RxSwift
import RxCocoa


protocol BeersListInteractorType {
    var listItems: Driver<[BeerListItem]> {get}
    var currentBeerInfos: [BeerInfo] {get}
    var isInActivity: Driver<Bool> {get}
    
    func loadBeersListIfNeeded()
    func loadMoreData()
    func updateFavoriteBeersStorage(with beerID: Int)
    func isFavoriteItem(beerID: Int) -> Bool
}

final class BeersListInteractor: BeersListInteractorType {
    typealias Context = BeersAPIContext & DataContext
        & FavoriteBeersStorageContext
    
    let listItems: Driver<[BeerListItem]>
    private let listItemsRelay = BehaviorRelay<[BeerListItem]>(value: [])
    
    let isInActivity: Driver<Bool>
    private let isLoadingInProgressRelay = BehaviorRelay<Bool>(value: false)
    
    var currentBeerInfos: [BeerInfo] {
        return beersFRC.currentItem
    }
    
    private let context: Context
    private let dataSource: BeersDataSourceType
    private let beersFRC: MultiFetchedResultsControllerDelegate<BeerInfo>
    private let favoriteStorage: FavoriteBeersStorageType
    private let disposeBag = DisposeBag()
    
    init(context: Context) {
        self.context = context
        self.dataSource = BeersDataSource(context: context)
        self.beersFRC = dataSource.makeBaseBeersFRC()
        self.favoriteStorage = context.favoriteBeersStorage
        self.isInActivity = isLoadingInProgressRelay.asDriver()
        self.listItems = listItemsRelay.asDriver()
        
        Driver.combineLatest(beersFRC.fetchedItem, favoriteStorage.favoriteBeerIDs)
            .map { [unowned self] in self.makeBeerItemsList(infos: $0, favoriteBeerIDs: $1) }
            .drive(listItemsRelay)
            .disposed(by: disposeBag)
    }
    
    func loadBeersListIfNeeded() {
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
    
    func updateFavoriteBeersStorage(with beerID: Int) {
        let storageIDs = favoriteStorage.readFavoriteBeerIDs()
        if storageIDs.contains(beerID) {
            favoriteStorage.remove(favoriteBeerID: beerID)
        } else {
            favoriteStorage.add(favoriteBeerID: beerID)
        }
    }
    
    func isFavoriteItem(beerID: Int) -> Bool {
        let storageIDs = favoriteStorage.readFavoriteBeerIDs()
        return storageIDs.contains(beerID)
    }
}

// MARK: - Data mapping
private extension BeersListInteractor {
    func makeBeerItemsList(infos: [BeerInfo], favoriteBeerIDs: Set<Int>) -> [BeerListItem] {
        return infos.map { beerInfo -> BeerListItem in
            let isFavorite = favoriteBeerIDs.contains(Int(beerInfo.id))
            return BeerListItem(beerInfo: beerInfo, isFavorite: isFavorite)
        }
    }
}

// MARK: - Data loading
private extension BeersListInteractor {
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
