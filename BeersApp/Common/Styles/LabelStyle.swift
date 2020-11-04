//
//  LabelStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 02.11.2020.
//

import UIKit


protocol LabelStyleType {
    var textFont: UIFont {get}
    var textColor: UIColor {get}
}

extension UILabel {
    func apply(style: LabelStyleType) {
        self.font = style.textFont
        self.textColor = style.textColor
    }
}

extension LabelStyleType {
    var textFont: UIFont { return UIFont.systemFont(ofSize: 17) }
    var textColor: UIColor { return appColors.sandDune }
}

struct LabelStyle: LabelStyleType {
    var textFont: UIFont
    var textColor: UIColor
}
