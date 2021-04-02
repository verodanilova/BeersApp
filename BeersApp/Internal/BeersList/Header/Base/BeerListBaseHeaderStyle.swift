//
//  BeerListBaseHeaderStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 02.04.2021.
//

import UIKit


protocol BeerListBaseHeaderStyleType {
    var headerBackgroundColor: UIColor {get}
    var titleLabelStyle: LabelStyleType {get}
    var filtersButtonStyle: ButtonStyleType {get}
}

struct BeerListBaseHeaderStyle: BeerListBaseHeaderStyleType {
    var headerBackgroundColor: UIColor {
        .white
    }
    var titleLabelStyle: LabelStyleType {
        LabelStyle(
            textFont: .bold(ofSize: 28),
            textColor: .mineShaft)
    }
    var filtersButtonStyle: ButtonStyleType {
        FiltersButtonStyle()
    }
}

private struct FiltersButtonStyle: ButtonStyleType {
    var titleFont: UIFont {
        return .semibold(ofSize: 20)
    }
    var titleColorNormal: UIColor? {
        return .freshEggplant
    }
    var titleColorHighlighted: UIColor? {
        return .purple
    }
    var contentInsets: UIEdgeInsets {
        UIEdgeInsets(top: 6, left: 8, bottom: 8, right: 8)
    }
}

