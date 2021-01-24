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
        return .white
    }
    var titleLabelStyle: LabelStyle {
        return LabelStyle(
            textFont: .systemFont(ofSize: 20, weight: .semibold),
            textColor: .mineShaft)
    }
    var taglineLabelStyle: LabelStyle {
        return LabelStyle(
            textFont: .italicSystemFont(ofSize: 16),
            textColor: .sandDune)
    }
    var separatorViewColor: UIColor {
        return .alto
    }
    var figuresTitleLabelStyle: LabelStyle {
        return LabelStyle(
            textFont: .systemFont(ofSize: 16, weight: .regular),
            textColor: .sandDune)
    }
    var figuresIndexLabelStyle: LabelStyle {
        return LabelStyle(
            textFont: .systemFont(ofSize: 18, weight: .medium),
            textColor: .sandDune)
    }
    var colorValueViewStyle: ViewStyleType {
        return ViewStyle(cornerRadius: 4, borderWidth: 1, borderColor: .alto)
    }
    var sectionTitleLabelStyle: LabelStyle {
        return LabelStyle(
            textFont: .systemFont(ofSize: 18, weight: .medium),
            textColor: .mineShaft)
    }
    var sectionTextLabelStyle: LabelStyle {
        return LabelStyle(
            textFont: .systemFont(ofSize: 16, weight: .regular),
            textColor: .mineShaft)
    }
    var colorForBeerColorKind: (BeerColorKind) -> UIColor? = { kind in
        switch kind {
            case .paleStraw: return beerColors.paleStraw
            case .straw: return beerColors.straw
            case .paleGold: return beerColors.paleGold
            case .deepGold: return beerColors.deepGold
            case .paleAmber: return beerColors.paleAmber
            case .mediumAmber: return beerColors.mediumAmber
            case .deepAmber: return beerColors.deepAmber
            case .amberBrown: return beerColors.amberBrown
            case .brown: return beerColors.brown
            case .rubyBrown: return beerColors.rubyBrown
            case .deepBrown: return beerColors.deepBrown
            case .black: return beerColors.black
            case .unknown: return nil
        }
    }
}
