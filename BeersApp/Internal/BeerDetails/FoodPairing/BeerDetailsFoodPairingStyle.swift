//
//  BeerDetailsFoodPairingStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 22.03.2021.
//

import UIKit

protocol BeerDetailsFoodPairingStyleType {
    var pairingBackgroundColor: UIColor {get}
    var titleLabelStyle: LabelStyleType {get}
    var chipStyle: ButtonStyleType {get}
}

struct BeerDetailsFoodPairingStyle: BeerDetailsFoodPairingStyleType {
    var pairingBackgroundColor: UIColor {
        .white
    }
    var titleLabelStyle: LabelStyleType {
        return LabelStyle(
            textFont: .semibold(ofSize: 22),
            textColor: .mineShaft)
    }
    var chipStyle: ButtonStyleType {
        ChipButtonStyle()
    }
}

private struct ChipButtonStyle: ButtonStyleType {
    var titleFont: UIFont { .regular(ofSize: 20) }
    var titleColorNormal: UIColor? { .mineShaft }
    var titleColorHighlighted: UIColor? { .sandDune }
    var cornerRadius: CGFloat { 18.0 }
    var backgroundColor: UIColor? { .white }
    var contentInsets: UIEdgeInsets { UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) }
    var borderColor: UIColor? { .alto }
    var borderWidth: CGFloat { 1.0 }
}
