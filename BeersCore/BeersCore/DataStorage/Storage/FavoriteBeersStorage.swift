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

public final class FavoriteBeersStorage: FavoriteBeersStorageType {
    private let userDefaults = UserDefaults.standard
    
    public let favoriteBeerIDs: Driver<BeerIDsSet>
    private let favoriteBeerIDsRelay = BehaviorRelay<BeerIDsSet>(value: Set())
    
    public init() {
        self.favoriteBeerIDs = favoriteBeerIDsRelay.asDriver()
        favoriteBeerIDsRelay.accept(readFavoriteBeerIDs())
    }
    
    public func add(favoriteBeerID id: Int) {
        var beerIDsSet = readFavoriteBeerIDs()
        beerIDsSet.insert(id)
        userDefaults.set(Array(beerIDsSet), forKey: favoriteBeerIDsKey)
        favoriteBeerIDsRelay.accept(beerIDsSet)
    }
    
    public func remove(favoriteBeerID id: Int) {
        var beerIDsSet = readFavoriteBeerIDs()
        beerIDsSet.remove(id)
        userDefaults.set(Array(beerIDsSet), forKey: favoriteBeerIDsKey)
        favoriteBeerIDsRelay.accept(beerIDsSet)
    }
    
    public func readFavoriteBeerIDs() -> BeerIDsSet {
        if let value = userDefaults.array(forKey: favoriteBeerIDsKey) as? [Int] {
            return Set(value)
        } else {
            return BeerIDsSet()
        }
    }
}
