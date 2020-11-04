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
    var itemStyle: BeersListItemStyleType {get}
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
    public var separatorInset: UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    public var separatorColor: UIColor {
        return appColors.alto
    }
    public var itemStyle: BeersListItemStyleType {
        return BeersListItemStyle()
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
