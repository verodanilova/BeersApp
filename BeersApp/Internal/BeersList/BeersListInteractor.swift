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
    var errorOccurredSignal: Signal<Void> {get}
    
    /* Data loading */
    func loadBeersListIfNeeded()
    func loadMoreData()
    
    /* Data with filters loading */
    func loadBeersListWithFilters(storage: BeerFiltersStorageType)
    func resetFilters()
    
    /* Storage updates */
    func updateFavoriteBeersStorage(with beerID: Int)
    func isFavoriteItem(beerID: Int) -> Bool
}

final class BeersListInteractor: BeersListInteractorType {
    typealias Context = BeersAPIContext & BeersDataSourceContext
        & FavoriteBeersStorageContext
    
    let listItems: Driver<[BeerListItem]>
    private let listItemsRelay = BehaviorRelay<[BeerListItem]>(value: [])
    
    let isInActivity: Driver<Bool>
    private let isLoadingInProgressRelay = BehaviorRelay<Bool>(value: false)
    
    let errorOccurredSignal: Signal<Void>
    private let errorOccurredRelay = PublishRelay<Void>()
    
    var currentBeerInfos: [BeerInfo] {
        return beersFRC?.currentItem ?? []
    }
    
    private let context: Context
    private let dataSource: BeersDataSourceType
    private let favoriteStorage: FavoriteBeersStorageType
    private var paginationStateController: PaginationStateControllerType
    private var beersFRC: MultiFetchedResultsControllerDelegate<BeerInfo>?
    private var filtersStorage: BeerFiltersStorageType?
    private let disposeBag = DisposeBag()
    private var frcDisposeBag = DisposeBag()
    
    init(context: Context) {
        self.context = context
        self.dataSource = context.beersDataSource
        self.favoriteStorage = context.favoriteBeersStorage
        self.paginationStateController = PaginationStateController()
        self.isInActivity = isLoadingInProgressRelay.asDriver()
        self.listItems = listItemsRelay.asDriver()
        self.errorOccurredSignal = errorOccurredRelay.asSignal()
        
        startFetchingItems()
    }
    
    func loadBeersListIfNeeded() {
        if paginationStateController.nextPage == 1 {
            loadNewData()
        }
    }
    
    func loadMoreData() {
        loadNewData(paginationStateController.nextPage)
    }
    
    func loadBeersListWithFilters(storage: BeerFiltersStorageType) {
        filtersStorage = storage
        startFetchingItems()
        loadBeersListIfNeeded()
    }
    
    func resetFilters() {
        filtersStorage = nil
        startFetchingItems()
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

// MARK: - Data fetching
private extension BeersListInteractor {
    func startFetchingItems() {
        frcDisposeBag = DisposeBag()
        paginationStateController.resetState()
        
        if let filtersStorage = filtersStorage {
            self.beersFRC = dataSource.makeFilteredBeersFRC(storage: filtersStorage)
        } else {
            self.beersFRC = dataSource.makeBaseBeersFRC()
        }

        Driver.combineLatest(beersFRC!.fetchedItem, favoriteStorage.favoriteBeerIDs)
            .map { [unowned self] in self.makeBeerItemsList(infos: $0, favoriteBeerIDs: $1) }
            .drive(listItemsRelay)
            .disposed(by: frcDisposeBag)
        
        beersFRC?.fetchedItem
            .drive(onNext: paginationStateController.setStoredItems)
            .disposed(by: frcDisposeBag)
    }
    
    func makeBeerItemsList(infos: [BeerInfo], favoriteBeerIDs: Set<Int>) -> [BeerListItem] {
        return infos.map { beerInfo -> BeerListItem in
            let isFavorite = favoriteBeerIDs.contains(Int(beerInfo.id))
            return BeerListItem(beerInfo: beerInfo, isFavorite: isFavorite)
        }
    }
}

// MARK: - Data loading
private extension BeersListInteractor {
    func loadNewData(_ page: Int? = nil) {
        guard !isLoadingInProgressRelay.value else { return }
        guard paginationStateController.isPaginationEnabled else { return }
        
        if let filtersStorage = filtersStorage {
            loadFilteredBeersList(storage: filtersStorage, page: page)
        } else {
            loadBeersList(page)
        }
    }
    
    func loadBeersList(_ page: Int? = nil) {
        isLoadingInProgressRelay.accept(true)
        
        var request = GetBeersListRequest()
        if let loadingPage = page {
            request = GetBeersListRequest(page: loadingPage)
        }
        
        context.beersAPI.getBeersList(request)
            .subscribe(onSuccess: { [weak self] list in
                self?.isLoadingInProgressRelay.accept(false)
                self?.paginationStateController.newLoadedItems(list)
            }, onError: { [weak self] error in
                self?.isLoadingInProgressRelay.accept(false)
                self?.errorOccurredRelay.accept(())
            })
            .disposed(by: disposeBag)
    }
    
    func loadFilteredBeersList(storage: BeerFiltersStorageType, page: Int? = nil) {
        isLoadingInProgressRelay.accept(true)

        let request: GetFilteredBeersListRequest
        if let loadingPage = page {
            request = GetFilteredBeersListRequest(storage: storage, page: loadingPage)
        } else {
            request = GetFilteredBeersListRequest(storage: storage)
        }
        
        context.beersAPI.getFilteredBeersList(request)
            .subscribe(onSuccess: { [weak self] list in
                self?.isLoadingInProgressRelay.accept(false)
                self?.paginationStateController.newLoadedItems(list)
            }, onError: { [weak self] error in
                self?.isLoadingInProgressRelay.accept(false)
                print("Error while loading filtered beers list: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
