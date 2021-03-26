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
    var infoViewStyle: BeerDetailsInfoStyleType {
        return BeerDetailsInfoStyle()
    }
    var foodPairingStyle: BeerDetailsFoodPairingStyleType {
        return BeerDetailsFoodPairingStyle()
    }
}

private struct ToFavoritesButtonStyle: ButtonStyleType {
    var titleColorNormal: UIColor? {
        return .mineShaft
    }
    var titleColorHighlighted: UIColor? {
        return .sandDune
    }
    var cornerRadius: CGFloat {
        return 6
    }
    var backgroundColor: UIColor? {
        return .gold
    }
    var shadowLayer: ButtonShadowLayer? {
        return ButtonShadowLayer(
            color: .sandDune,
            opacity: 0.4,
            offset: CGSize(width: 0, height: 2),
            radius: 4)
    }
}
