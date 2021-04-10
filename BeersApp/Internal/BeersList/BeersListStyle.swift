//
//  BeersListStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import UIKit


protocol BeersListStyleType {
    var backgroundColor: UIColor {get}
    var tableViewBackgroundColor: UIColor {get}
    var swipeActionBackgroundColor: UIColor {get}
    var itemStyle: BeersListItemStyleType {get}
    var baseHeaderStyle: BeerListBaseHeaderStyleType {get}
    var filteredHeaderStyle: BeerListFilteredHeaderStyleType {get}
    var footerStyle: BeersListFooterStyleType {get}
    var errorBackgroundColor: UIColor {get}
    var errorTextStyle: LabelStyleType {get}
}

struct BeersListStyle: BeersListStyleType {
    var backgroundColor: UIColor {
        return .white
    }
    var tableViewBackgroundColor: UIColor {
        return .white
    }
    var swipeActionBackgroundColor: UIColor {
        return UIColor.sandDune.withAlphaComponent(0.7)
    }
    var itemStyle: BeersListItemStyleType {
        return BeersListItemStyle()
    }
    var baseHeaderStyle: BeerListBaseHeaderStyleType {
        BeerListBaseHeaderStyle()
    }
    var filteredHeaderStyle: BeerListFilteredHeaderStyleType {
        return BeerListFilteredHeaderStyle()
    }
    var footerStyle: BeersListFooterStyleType {
        return BeersListFooterStyle()
    }
    var errorBackgroundColor: UIColor {
        return .carnation
    }
    var errorTextStyle: LabelStyleType {
        return LabelStyle(
            textFont: .regular(ofSize: 18),
            textColor: .white)
    }
}
