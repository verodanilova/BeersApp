//
//  BeerDetailsInfoStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 07.11.2020.
//

import UIKit
import BeersCore

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
    var topCornerRadius: CGFloat {get}
}

struct BeerDetailsInfoStyle: BeerDetailsInfoStyleType {
    var infoBackgroundColor: UIColor {
        return .white
    }
    var titleLabelStyle: LabelStyle {
        return LabelStyle(
            textFont: .bold(ofSize: 24),
            textColor: .freshEggplant)
    }
    var taglineLabelStyle: LabelStyle {
        return LabelStyle(
            textFont: .regular(ofSize: 20),
            textColor: .mineShaft)
    }
    var separatorViewColor: UIColor {
        return .alto
    }
    var figuresTitleLabelStyle: LabelStyle {
        return LabelStyle(
            textFont: .regular(ofSize: 18),
            textColor: .sandDune)
    }
    var figuresIndexLabelStyle: LabelStyle {
        return LabelStyle(
            textFont: .semibold(ofSize: 20),
            textColor: .sandDune)
    }
    var colorValueViewStyle: ViewStyleType {
        return ViewStyle(cornerRadius: 4, borderWidth: 1, borderColor: .alto)
    }
    var sectionTitleLabelStyle: LabelStyle {
        return LabelStyle(
            textFont: .semibold(ofSize: 22),
            textColor: .mineShaft)
    }
    var sectionTextLabelStyle: LabelStyle {
        return LabelStyle(
            textFont: .regular(ofSize: 20),
            textColor: .mineShaft)
    }
    var topCornerRadius: CGFloat { 32.0 }
}
