//
//  BeerDetailsInfoStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 07.11.2020.
//

import UIKit


protocol BeerDetailsInfoStyleType {
    var infoBackgroundColor: UIColor {get}
    var titleLabelStyle: LabelStyle {get}
    var taglineLabelStyle: LabelStyle {get}
    var separatorViewColor: UIColor {get}
    var figuresTitleLabelStyle: LabelStyle {get}
    var figuresIndexLabelStyle: LabelStyle {get}
    var colorValueViewStyle: ViewStyleType {get}
    var sectionTitleLabelStyle: LabelStyle {get}
    var sectionTextLabelStyle: LabelStyle {get}
    var colorForBeerColorKind: (BeerColorKind) -> UIColor? {get}
}

struct BeerDetailsInfoStyle: BeerDetailsInfoStyleType {
    var infoBackgroundColor: UIColor {
        return appColors.white
    }
    var titleLabelStyle: LabelStyle {
        return LabelStyle(
            textFont: .systemFont(ofSize: 20, weight: .semibold),
            textColor: appColors.mineShaft)
    }
    var taglineLabelStyle: LabelStyle {
        return LabelStyle(
            textFont: .italicSystemFont(ofSize: 16),
            textColor: appColors.sandDune)
    }
    var separatorViewColor: UIColor {
        return appColors.alto
    }
    var figuresTitleLabelStyle: LabelStyle {
        return LabelStyle(
            textFont: .systemFont(ofSize: 16, weight: .regular),
            textColor: appColors.sandDune)
    }
    var figuresIndexLabelStyle: LabelStyle {
        return LabelStyle(
            textFont: .systemFont(ofSize: 18, weight: .medium),
            textColor: appColors.sandDune)
    }
    var colorValueViewStyle: ViewStyleType {
        return ViewStyle(cornerRadius: 4, borderWidth: 1, borderColor: appColors.alto)
    }
    var sectionTitleLabelStyle: LabelStyle {
        return LabelStyle(
            textFont: .systemFont(ofSize: 18, weight: .medium),
            textColor: appColors.mineShaft)
    }
    var sectionTextLabelStyle: LabelStyle {
        return LabelStyle(
            textFont: .systemFont(ofSize: 16, weight: .regular),
            textColor: appColors.mineShaft)
    }
    var colorForBeerColorKind: (BeerColorKind) -> UIColor? = { kind in
        switch kind {
            case .paleStraw: return appColors.beerColors.paleStraw
            case .straw: return appColors.beerColors.straw
            case .paleGold: return appColors.beerColors.paleGold
            case .deepGold: return appColors.beerColors.deepGold
            case .paleAmber: return appColors.beerColors.paleAmber
            case .mediumAmber: return appColors.beerColors.mediumAmber
            case .deepAmber: return appColors.beerColors.deepAmber
            case .amberBrown: return appColors.beerColors.amberBrown
            case .brown: return appColors.beerColors.brown
            case .rubyBrown: return appColors.beerColors.rubyBrown
            case .deepBrown: return appColors.beerColors.deepBrown
            case .black: return appColors.beerColors.black
            case .unknown: return nil
        }
    }
}
