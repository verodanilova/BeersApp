//
//  BeerListItem.swift
//  BeersApp
//
//  Created by Veronica Danilova on 08.11.2020.
//

import Foundation


struct BeerListItem {
    var name: String?
    var tagline: String?
    var imageURL: URL?
    var isFavorite: Bool
    
    init(beerInfo: BeerInfo, isFavorite: Bool = false) {
        self.name = beerInfo.name
        self.tagline = beerInfo.tagline
        self.imageURL = beerInfo.imageURL
        self.isFavorite = isFavorite
    }
}
