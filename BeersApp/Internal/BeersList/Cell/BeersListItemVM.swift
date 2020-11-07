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
}

final class BeersListItemViewModel: BeersListItemViewModelType {
    let name: String?
    let tagline: String?

    init(item: BeerInfo) {
        self.name = item.name
        self.tagline = item.tagline
    }
}
