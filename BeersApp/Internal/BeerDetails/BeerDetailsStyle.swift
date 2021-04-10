//
//  BeerDetailsStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 07.11.2020.
//

import UIKit


protocol BeerDetailsStyleType {
    var backgroundColor: UIColor {get}
    var imageContainerBackgroundColor: UIColor {get}
    var infoBackViewBackgroundColor: UIColor {get}
    var toFavoritesButtonStyle: ButtonStyleType {get}
    var isFavoriteImage: UIImage? {get}
    var isNotFavoriteImage: UIImage? {get}
    var infoViewStyle: BeerDetailsInfoStyleType {get}
    var foodPairingStyle: BeerDetailsFoodPairingStyleType {get}
}

struct BeerDetailsStyle: BeerDetailsStyleType {
    var backgroundColor: UIColor {
        .albescentWhite
    }
    var imageContainerBackgroundColor: UIColor {
        return .clear
    }
    var infoBackViewBackgroundColor: UIColor {
        return .clear
    }
    var toFavoritesButtonStyle: ButtonStyleType {
        return ToFavoritesButtonStyle()
    }
    var isFavoriteImage: UIImage? {
        UIImage(named: "heart_filled_ic")?
            .withTintColor(.freshEggplant, renderingMode: .automatic)
    }
    var isNotFavoriteImage: UIImage? {
        UIImage(named: "heart_ic")?
            .withTintColor(.sandDune, renderingMode: .automatic)
    }
    var infoViewStyle: BeerDetailsInfoStyleType {
        return BeerDetailsInfoStyle()
    }
    var foodPairingStyle: BeerDetailsFoodPairingStyleType {
        return BeerDetailsFoodPairingStyle()
    }
}

private struct ToFavoritesButtonStyle: ButtonStyleType {
    var cornerRadius: CGFloat {
        return 28
    }
    var backgroundColor: UIColor? {
        UIColor.white.withAlphaComponent(0.7)
    }
    var contentInsets: UIEdgeInsets {
        UIEdgeInsets(top: 17, left: 16, bottom: 15, right: 16)
    }
}
