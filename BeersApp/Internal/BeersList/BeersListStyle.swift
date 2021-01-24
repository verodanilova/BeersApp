//
//  BeersListStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import UIKit


protocol BeersListStyleType {
    var backgroundColor: UIColor {get}
    var filtersButtonStyle: ButtonStyleType {get}
    var tableViewBackgroundColor: UIColor {get}
    var separatorInset: UIEdgeInsets {get}
    var separatorColor: UIColor {get}
    var swipeActionBackgroundColor: UIColor {get}
    var itemStyle: BeersListItemStyleType {get}
    var headerStyle: BeersListHeaderStyleType {get}
    var footerStyle: BeersListFooterStyleType {get}
    var errorBackgroundColor: UIColor {get}
    var errorTextStyle: LabelStyleType {get}
}

struct BeersListStyle: BeersListStyleType {
    var backgroundColor: UIColor {
        return .white
    }
    var filtersButtonStyle: ButtonStyleType {
        return FiltersButtonStyle()
    }
    var tableViewBackgroundColor: UIColor {
        return .white
    }
    var separatorInset: UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    var separatorColor: UIColor {
        return .alto
    }
    var swipeActionBackgroundColor: UIColor {
        return UIColor.sandDune.withAlphaComponent(0.7)
    }
    var itemStyle: BeersListItemStyleType {
        return BeersListItemStyle()
    }
    var headerStyle: BeersListHeaderStyleType {
        return BeersListHeaderStyle()
    }
    var footerStyle: BeersListFooterStyleType {
        return BeersListFooterStyle()
    }
    var errorBackgroundColor: UIColor {
        return .carnation
    }
    var errorTextStyle: LabelStyleType {
        return LabelStyle(
            textFont: .systemFont(ofSize: 14, weight: .medium),
            textColor: .white)
    }
}

private struct FiltersButtonStyle: ButtonStyleType {
    var titleFont: UIFont {
        return .systemFont(ofSize: 16, weight: .medium)
    }
    var titleColorNormal: UIColor? {
        return .white
    }
    var titleColorHighlighted: UIColor? {
        return .white
    }
    var cornerRadius: CGFloat {
        return 22
    }
    var backgroundColor: UIColor? {
        return .bostonBlue
    }
    var shadowLayer: ButtonShadowLayer? {
        return ButtonShadowLayer(
            color: .sandDune,
            opacity: 0.4,
            offset: CGSize(width: 0, height: 2),
            radius: 4)
    }
}
