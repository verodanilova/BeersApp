//
//  ButtonStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import UIKit


protocol ButtonStyleType {
    var titleFont: UIFont {get}
    var tintColor: UIColor {get}
    var titleColorNormal: UIColor? {get}
    var titleColorHighlighted: UIColor? {get}
    var cornerRadius: CGFloat {get}
    var backgroundColor: UIColor? {get}
    var borderColor: UIColor? {get}
    var borderWidth: CGFloat {get}
}

extension UIButton {
    func apply(style: ButtonStyleType) {
        self.titleLabel?.font = style.titleFont
        self.tintColor = style.tintColor
        self.setTitleColor(style.titleColorNormal, for: .normal)
        self.setTitleColor(style.titleColorHighlighted, for: .highlighted)
        self.layer.cornerRadius = style.cornerRadius
        self.clipsToBounds = style.cornerRadius != 0
        self.backgroundColor = style.backgroundColor
        self.layer.borderColor = style.borderColor?.cgColor
        self.layer.borderWidth = style.borderWidth
    }
}

extension ButtonStyleType {
    var titleFont: UIFont { return UIFont.systemFont(ofSize: 17) }
    var tintColor: UIColor { return appColors.sandDune }
    var titleColorNormal: UIColor? { return nil }
    var titleColorHighlighted: UIColor? { return nil }
    var cornerRadius: CGFloat { return 0 }
    var backgroundColor: UIColor? { return nil }
    var borderColor: UIColor? { return nil }
    var borderWidth: CGFloat { return 0  }
}

