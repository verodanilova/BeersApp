//
//  BeerListFilteredHeaderStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 02.04.2021.
//

import UIKit

protocol BeerListFilteredHeaderStyleType {
    var headerBackgroundColor: UIColor {get}
    var filteredTitleTextStyle: LabelStyle {get}
    var resetButtonStyle: ButtonStyleType {get}
    var separatorColor: UIColor {get}
    var chipTextStyle: LabelStyleType {get}
    var chipViewStyle: ViewStyleType {get}
    var closeButtonStyle: ButtonStyleType {get}
}

struct BeerListFilteredHeaderStyle: BeerListFilteredHeaderStyleType {
    var headerBackgroundColor: UIColor {
        return .white
    }
    var filteredTitleTextStyle: LabelStyle {
        LabelStyle(
            textFont: .bold(ofSize: 28),
            textColor: .mineShaft)
    }
    var resetButtonStyle: ButtonStyleType {
        return ResetButtonStyle()
    }
    var separatorColor: UIColor {
        return .alto
    }
    var chipTextStyle: LabelStyleType {
        LabelStyle(
            textFont: .regular(ofSize: 20),
            textColor: .mineShaft)
    }
    var chipViewStyle: ViewStyleType {
        ChipViewStyle()
    }
    var closeButtonStyle: ButtonStyleType {
        CloseButtonStyle()
    }
}

private struct ResetButtonStyle: ButtonStyleType {
    var titleFont: UIFont {
        return .regular(ofSize: 20)
    }
    var titleColorNormal: UIColor? {
        return .mineShaft
    }
    var titleColorHighlighted: UIColor? {
        return .sandDune
    }
    var cornerRadius: CGFloat { 18.0 }
    var borderWidth: CGFloat { 1.0 }
    var borderColor: UIColor? { .mineShaft }
    var backgroundColor: UIColor? { .white }
    var contentInsets: UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

private struct ChipViewStyle: ViewStyleType {
    var cornerRadius: CGFloat? { 18.0 }
    var borderWidth: CGFloat? { 1.0 }
    var borderColor: UIColor? { .freshEggplant }
    var backgroundColor: UIColor? { .white }
}

private struct CloseButtonStyle: ButtonStyleType {
    var image: ButtonImage? {
        let insets = UIEdgeInsets(top: 14, left: 12, bottom: 12, right: 12)
        return ButtonImage(name: "close_ic",
                           renderingMode: .automatic,
                           tintColor: .mineShaft,
                           insets: insets,
                           horizontalAlignment: .fill,
                           contentMode: .scaleAspectFit)
    }
}
