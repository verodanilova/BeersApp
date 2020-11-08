//
//  BeersListItemViewModel.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import Foundation


protocol BeersListItemViewModelType {
    var name: String? {get}
    var tagline: String? {get}
    var imageURL: URL? {get}
    var isFavoriteBeer: Bool {get}
}

final class BeersListItemViewModel: BeersListItemViewModelType {
    let name: String?
    let tagline: String?
    let imageURL: URL?
    let isFavoriteBeer: Bool

    init(item: BeerListItem) {
        self.name = item.name
        self.tagline = item.tagline
        self.imageURL = item.imageURL
        self.isFavoriteBeer = item.isFavorite
    }
}
