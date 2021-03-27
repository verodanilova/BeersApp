//
//  FavoritesCellStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 27.03.2021.
//

import UIKit

protocol FavoritesCellStyleType {
    var tileBackgroundColor: UIColor {get}
    var tileCornerRadius: CGFloat {get}
    var nameLabelStyle: LabelStyleType {get}
    var sectionValueLabelStyle: LabelStyle {get}
    var sectionLabelStyle: LabelStyle {get}
}

struct FavoritesCellStyle: FavoritesCellStyleType {
    var tileBackgroundColor: UIColor { .swirl }
    var tileCornerRadius: CGFloat { 24.0 }
    
    var nameLabelStyle: LabelStyleType {
        return LabelStyle(
            textFont: .bold(ofSize: 24),
            textColor: .white)
    }
    var sectionValueLabelStyle: LabelStyle {
        return LabelStyle(
            textFont: .semibold(ofSize: 22),
            textColor: .white)
    }
    var sectionLabelStyle: LabelStyle {
        return LabelStyle(
            textFont: .regular(ofSize: 18),
            textColor: .white)
    }
}
