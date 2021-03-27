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
    var isFavorite: Driver<Bool> {get}
    var infoViewModel: BeerDetailsInfoViewModelType {get}
    var foodPairingViewModel: BeerDetailsFoodPairingViewModelType {get}
    var isInActivity: Driver<Bool> {get}
    
    func bindViewEvents(toFavoritesTap: Signal<Void>)
}

final class BeerDetailsViewModel: BeerDetailsViewModelType {
    typealias Context = FavoriteBeersStorageContext & BeerDetailsInteractor.Context
    
    let imageURL: Driver<URL?>
    let isFavorite: Driver<Bool>
    let infoViewModel: BeerDetailsInfoViewModelType
    let foodPairingViewModel: BeerDetailsFoodPairingViewModelType
    let isInActivity: Driver<Bool>
    
    private let storage: FavoriteBeersStorageType
    private let interactor: BeerDetailsInteractorType
    private let itemID: Int
    private let disposeBag = DisposeBag()

    init(context: Context, id: Int) {
        self.itemID = id
        self.storage = context.favoriteBeersStorage
        self.interactor = BeerDetailsInteractor(context: context, beerID: id)
        self.imageURL = interactor.beerInfo.map { $0.imageURL }
        self.infoViewModel = BeerDetailsInfoViewModel(info: interactor.beerInfo)
        self.foodPairingViewModel = BeerDetailsFoodPairingViewModel(
            foodPairings: interactor.beerInfo.map({ $0.foodPairings }))
        self.isInActivity = interactor.isInActivity
        self.isFavorite = storage.favoriteBeerIDs
            .map { $0.contains(id) }
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
