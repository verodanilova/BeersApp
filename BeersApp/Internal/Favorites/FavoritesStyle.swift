//
//  FavoritesStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 27.03.2021.
//

import UIKit

protocol FavoritesStyleType {
    var titleLabelStyle: LabelStyleType {get}
    var descriptionLabelStyle: LabelStyleType {get}
    var cellStyle: FavoritesCellStyleType {get}
}

struct FavoritesStyle: FavoritesStyleType {
    var titleLabelStyle: LabelStyleType {
        return LabelStyle(
            textFont: .bold(ofSize: 28),
            textColor: .mineShaft)
    }
    var descriptionLabelStyle: LabelStyleType {
        return LabelStyle(
            textFont: .regular(ofSize: 20),
            textColor: .sandDune)
    }
    var cellStyle: FavoritesCellStyleType {
        FavoritesCellStyle()
    }
}

