//
//  BeerListItem.swift
//  BeersApp
//
//  Created by Veronica Danilova on 08.11.2020.
//

import Foundation
import BeersCore


struct BeerListItem {
    var name: String?
    var tagline: String?
    var imageURL: URL?
    var alcoholIndex: Double
    var bitternessIndex: Double
    var colorKind: BeerColorKind
    var isFavorite: Bool
    
    init(beerInfo: BeerInfo, isFavorite: Bool = false) {
        self.name = beerInfo.name
        self.tagline = beerInfo.tagline
        self.imageURL = beerInfo.imageURL
        self.alcoholIndex = beerInfo.alcoholIndex
        self.bitternessIndex = beerInfo.bitternessIndex
        self.colorKind = beerInfo.colorKind
        self.isFavorite = isFavorite
    }
}
