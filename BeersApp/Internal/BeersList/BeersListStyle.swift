//
//  BeersListStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import UIKit


protocol BeersListStyleType {
    var backgroundColor: UIColor {get}
    var sortButtonStyle: ButtonStyleType {get}
    var tableViewBackgroundColor: UIColor {get}
    var separatorInset: UIEdgeInsets {get}
    var separatorColor: UIColor {get}
    var swipeActionBackgroundColor: UIColor {get}
    var itemStyle: BeersListItemStyleType {get}
    var headerStyle: BeersListHeaderStyleType {get}
    var footerStyle: BeersListFooterStyleType {get}
}

struct BeersListStyle: BeersListStyleType {
    var backgroundColor: UIColor {
        return .white
    }
    var sortButtonStyle: ButtonStyleType {
        return SortButtonStyle()
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
    var headerStyle: BeersListHeaderStyleType {
        return BeersListHeaderStyle()
    }
    var footerStyle: BeersListFooterStyleType {
        return BeersListFooterStyle()
    }
}

private struct SortButtonStyle: ButtonStyleType {
    var titleColorNormal: UIColor? {
        return appColors.bostonBlue
    }
    var titleColorHighlighted: UIColor? {
        return appColors.sandDune
    }
    var cornerRadius: CGFloat {
        return 2
    }
    var backgroundColor: UIColor? {
        return appColors.white
    }
    var borderColor: UIColor? {
        return appColors.bostonBlue
    }
    var borderWidth: CGFloat {
        return 1
    }
}
