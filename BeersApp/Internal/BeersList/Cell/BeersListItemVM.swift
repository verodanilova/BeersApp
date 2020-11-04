//
//  BeersListItemViewModel.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import Foundation


protocol BeersListItemViewModelType {
    var name: String {get}
    var tagline: String {get}
    var imageName: String {get}
}

final class BeersListItemViewModel: BeersListItemViewModelType {
    let name: String
    let tagline: String
    let imageName: String
    
    init(item: BeersListItem) {
        self.name = item.name
        self.tagline = item.tagline
        self.imageName = item.imageName
    }
}

// Temporary struct
struct BeersListItem {
    var name: String
    var tagline: String
    var imageName: String
}
