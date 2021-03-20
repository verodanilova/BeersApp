//
//  FavoriteBeersStorageType.swift
//  BeersCore
//
//  Created by Veronica Danilova on 20.03.2021.
//

import RxCocoa

public protocol FavoriteBeersStorageType {
    typealias BeerIDsSet = Set<Int>
    
    var favoriteBeerIDs: Driver<BeerIDsSet> {get}
    func add(favoriteBeerID id: Int)
    func remove(favoriteBeerID id: Int)
    func readFavoriteBeerIDs() -> BeerIDsSet
}
