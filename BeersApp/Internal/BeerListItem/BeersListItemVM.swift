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
    var showFavoriteIcons: Bool {get}
}

final class BeersListItemViewModel: BeersListItemViewModelType {
    let name: String?
    let tagline: String?
    let imageURL: URL?
    let isFavoriteBeer: Bool
    let showFavoriteIcons: Bool

    init(item: BeerListItem, showFavoriteIcons: Bool = true) {
        self.name = item.name
        self.tagline = item.tagline
        self.imageURL = item.imageURL
        self.isFavoriteBeer = item.isFavorite
        self.showFavoriteIcons = showFavoriteIcons
    }
}
