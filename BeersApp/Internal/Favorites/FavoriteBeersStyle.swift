//
//  FavoriteBeersStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 08.11.2020.
//

import UIKit


protocol FavoriteBeersStyleType {
    var backgroundColor: UIColor {get}
    var tableViewBackgroundColor: UIColor {get}
    var separatorInset: UIEdgeInsets {get}
    var separatorColor: UIColor {get}
    var swipeActionBackgroundColor: UIColor {get}
    var itemStyle: BeersListItemStyleType {get}
}

struct FavoriteBeersStyle: FavoriteBeersStyleType {
    var backgroundColor: UIColor {
        return appColors.white
    }
    var tableViewBackgroundColor: UIColor {
        return appColors.white
    }
    var separatorInset: UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    var separatorColor: UIColor {
        return appColors.alto
    }
    var swipeActionBackgroundColor: UIColor {
        return appColors.sandDune.withAlphaComponent(0.7)
    }
    var itemStyle: BeersListItemStyleType {
        return BeersListItemStyle()
    }
}