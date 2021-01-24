//
//  BeersListHeaderStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 11.11.2020.
//

import UIKit


protocol BeersListHeaderStyleType {
    var headerBackgroundColor: UIColor {get}
    var filtersInfoTextStyle: LabelStyle {get}
    var resetButtonStyle: ButtonStyleType {get}
    var separatorColor: UIColor {get}
}

struct BeersListHeaderStyle: BeersListHeaderStyleType {
    var headerBackgroundColor: UIColor {
        return .white
    }
    var filtersInfoTextStyle: LabelStyle {
        return LabelStyle(
            textFont: .systemFont(ofSize: 16, weight: .medium),
            textColor: .sandDune)
    }
    var resetButtonStyle: ButtonStyleType {
        return ResetButtonStyle()
    }
    var separatorColor: UIColor {
        return .alto
    }
}

private struct ResetButtonStyle: ButtonStyleType {
    var titleFont: UIFont {
        return .systemFont(ofSize: 16, weight: .medium)
    }
    var titleColorNormal: UIColor? {
        return .bostonBlue
    }
    var titleColorHighlighted: UIColor? {
        return .bostonBlue
    }
}
