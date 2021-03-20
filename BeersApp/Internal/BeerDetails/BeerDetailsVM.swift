//
//  BeerDetailsViewModel.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import Foundation
import RxSwift
import RxCocoa
import BeersCore


protocol BeerDetailsViewModelType {
    var imageURL: Driver<URL?> {get}
    var navigationBarTitle: Driver<String?> {get}
    var toFavoritesButtonTitle: Driver<String> {get}
    var infoViewModel: BeerDetailsInfoViewModelType {get}
    
    func bindViewEvents(toFavoritesTap: Signal<Void>)
}

final class BeerDetailsViewModel: BeerDetailsViewModelType {
    typealias Context = FavoriteBeersStorageContext & BeersDataSourceContext
        
    
    let imageURL: Driver<URL?>
    let navigationBarTitle: Driver<String?>
    let toFavoritesButtonTitle: Driver<String>
    let infoViewModel: BeerDetailsInfoViewModelType
    
    private let storage: FavoriteBeersStorageType
    private let itemID: Int
    private let beerFRC: FetchedResultsControllerDelegate<BeerInfo>
    private let disposeBag = DisposeBag()

    init(context: Context, id: Int) {
        self.itemID = id
        self.storage = context.favoriteBeersStorage
        self.beerFRC = context.beersDataSource.makeBeerInfoFRC(withID: id)
        
        let beerInfo = beerFRC.fetchedItem
        self.imageURL = beerInfo.map { $0.imageURL }
        self.navigationBarTitle = beerInfo.map { $0.name }
        self.infoViewModel = BeerDetailsInfoViewModel(info: beerInfo)
        
        let configurator = Configurator()
        self.toFavoritesButtonTitle = storage.favoriteBeerIDs
            .map { ($0, id) }
            .map(configurator.makeButtonTitle)
    }
    
    func bindViewEvents(toFavoritesTap: Signal<Void>) {
        toFavoritesTap
            .emit(onNext: weakly(self, type(of: self).favoritesButtonTap))
            .disposed(by: disposeBag)
    }
}

// MARK: - Actions
private extension BeerDetailsViewModel {
    func favoritesButtonTap() {
        let storageIDs = storage.readFavoriteBeerIDs()
        if storageIDs.contains(itemID) {
            storage.remove(favoriteBeerID: itemID)
        } else {
            storage.add(favoriteBeerID: itemID)
        }
    }
}

private struct Configurator {
    func makeButtonTitle(storage: Set<Int>, itemID: Int) -> String {
        if storage.contains(itemID) {
            return NSLocalizedString(
                "Beer details.Remove from favorites button.Title",
                comment: "Beer details: title for to favorites button")
        } else {
            return NSLocalizedString(
                "Beer details.Add to favorites button.Title",
                comment: "Beer details: title for to favorites button")
        }
    }
}
