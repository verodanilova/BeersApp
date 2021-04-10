//
//  BeersListItemStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 02.11.2020.
//

import UIKit


protocol BeersListItemStyleType {
    var beerNameTextStyle: LabelStyleType {get}
    var figureLabelStyle: LabelStyleType {get}
    var figureValueStyle: LabelStyleType {get}
    var toFavoritesButtonStyle: ButtonStyleType {get}
    var isFavoriteImage: UIImage? {get}
    var isNotFavoriteImage: UIImage? {get}
    var viewShadow: LayerShadow {get}
}

struct BeersListItemStyle: BeersListItemStyleType {
    var beerNameTextStyle: LabelStyleType {
        LabelStyle(
            textFont: .semibold(ofSize: 18),
            textColor: .mineShaft)
    }
    var figureLabelStyle: LabelStyleType {
        LabelStyle(
            textFont: .regular(ofSize: 16),
            textColor: .sandDune)
    }
    var figureValueStyle: LabelStyleType {
        LabelStyle(
            textFont: .regular(ofSize: 16),
            textColor: .sandDune)
    }
    var toFavoritesButtonStyle: ButtonStyleType {
        ToFavoritesButtonStyle()
    }
    var isFavoriteImage: UIImage? {
        UIImage(named: "heart_filled_ic")?
            .withTintColor(.freshEggplant, renderingMode: .automatic)
    }
    var isNotFavoriteImage: UIImage? {
        UIImage(named: "heart_ic")?
            .withTintColor(.sandDune, renderingMode: .automatic)
    }
    var viewShadow: LayerShadow {
        LayerShadow(color: .darkGray,
                    opacity: 0.3,
                    offset: CGSize(width: 0, height: 2),
                    radius: 4)
    }
}

private struct ToFavoritesButtonStyle: ButtonStyleType {
    var backgroundColor: UIColor? {
        UIColor.clear
    }
    var contentInsets: UIEdgeInsets {
        UIEdgeInsets(top: 13, left: 12, bottom: 11, right: 12)
    }
}
