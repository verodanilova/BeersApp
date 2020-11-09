//
//  ViewStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 08.11.2020.
//

import UIKit


protocol ViewStyleType {
    var cornerRadius: CGFloat? {get}
    var borderWidth: CGFloat? {get}
    var borderColor: UIColor? {get}
    var backgroundColor: UIColor? {get}
}

extension UIView {
    func apply(style: ViewStyleType) {
        if let cornerRadius = style.cornerRadius {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
        if let borderWidth = style.borderWidth, let borderColor = style.borderColor {
            self.layer.borderWidth = borderWidth
            self.layer.borderColor = borderColor.cgColor
        }
        self.backgroundColor = style.backgroundColor
    }
}

struct ViewStyle: ViewStyleType {
    var cornerRadius: CGFloat? = nil
    var borderWidth: CGFloat? = nil
    var borderColor: UIColor? = nil
    var backgroundColor: UIColor? = nil
}
