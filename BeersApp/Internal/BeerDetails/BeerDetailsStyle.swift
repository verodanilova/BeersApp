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
}

struct BeerDetailsStyle: BeerDetailsStyleType {
    var backgroundColor: UIColor {
        return appColors.white
    }
    var imageContainerBackgroundColor: UIColor {
        return appColors.clear
    }
    var infoBackViewBackgroundColor: UIColor {
        return appColors.white
    }
    var toFavoritesButtonStyle: ButtonStyleType {
        return ToFavoritesButtonStyle()
    }
    var infoViewStyle: BeerDetailsInfoStyleType {
        return BeerDetailsInfoStyle()
    }
}

private struct ToFavoritesButtonStyle: ButtonStyleType {
    var titleColorNormal: UIColor? {
        return appColors.mineShaft
    }
    var titleColorHighlighted: UIColor? {
        return appColors.sandDune
    }
    var cornerRadius: CGFloat {
        return 10
    }
    var backgroundColor: UIColor? {
        return appColors.gold
    }
    var shadowLayer: ButtonShadowLayer? {
        return ButtonShadowLayer(
            color: appColors.sandDune,
            opacity: 0.4,
            offset: CGSize(width: 0, height: 2),
            radius: 4)
    }
}
