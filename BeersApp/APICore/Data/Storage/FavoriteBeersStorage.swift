//
//  FavoriteBeersStorage.swift
//  BeersApp
//
//  Created by Veronica Danilova on 08.11.2020.
//

import Foundation
import RxSwift
import RxCocoa


private let favoriteBeerIDsKey = "favoriteBeerIDs"

protocol FavoriteBeersStorageType {
    typealias BeerIDsSet = Set<Int>
    
    var favoriteBeerIDs: Driver<BeerIDsSet> {get}
    func add(favoriteBeerID id: Int)
    func remove(favoriteBeerID id: Int)
    func readFavoriteBeerIDs() -> BeerIDsSet
}

final class FavoriteBeersStorage: FavoriteBeersStorageType {
    private let userDefaults = UserDefaults.standard
    
    let favoriteBeerIDs: Driver<BeerIDsSet>
    private let favoriteBeerIDsRelay = BehaviorRelay<BeerIDsSet>(value: Set())
    
    init() {
        self.favoriteBeerIDs = favoriteBeerIDsRelay.asDriver()
        favoriteBeerIDsRelay.accept(readFavoriteBeerIDs())
    }
    
    func add(favoriteBeerID id: Int) {
        var beerIDsSet = readFavoriteBeerIDs()
        beerIDsSet.insert(id)
        userDefaults.set(Array(beerIDsSet), forKey: favoriteBeerIDsKey)
        favoriteBeerIDsRelay.accept(beerIDsSet)
    }
    
    func remove(favoriteBeerID id: Int) {
        var beerIDsSet = readFavoriteBeerIDs()
        beerIDsSet.remove(id)
        userDefaults.set(Array(beerIDsSet), forKey: favoriteBeerIDsKey)
        favoriteBeerIDsRelay.accept(beerIDsSet)
    }
    
    func readFavoriteBeerIDs() -> BeerIDsSet {
        if let value = userDefaults.array(forKey: favoriteBeerIDsKey) as? [Int] {
            return Set(value)
        } else {
            return BeerIDsSet()
        }
    }
}
