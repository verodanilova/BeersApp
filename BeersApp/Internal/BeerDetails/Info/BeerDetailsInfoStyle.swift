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
    var sectionTitleLabelStyle: LabelStyle {get}
    var sectionTextLabelStyle: LabelStyle {get}
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
}
