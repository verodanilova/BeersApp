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
    }
}

struct ViewStyle: ViewStyleType {
    var cornerRadius: CGFloat?
    var borderWidth: CGFloat?
    var borderColor: UIColor?
}
