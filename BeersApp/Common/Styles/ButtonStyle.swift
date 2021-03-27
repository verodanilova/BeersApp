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
    var contentInsets: UIEdgeInsets {get}
    
    /* Border */
    var borderColor: UIColor? {get}
    var borderWidth: CGFloat {get}
    
    /* Shadow */
    var shadowLayer: ButtonShadowLayer? {get}
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
        self.contentEdgeInsets = style.contentInsets
        self.layer.borderColor = style.borderColor?.cgColor
        self.layer.borderWidth = style.borderWidth
        if let shadowLayer = style.shadowLayer {
            self.layer.shadowColor = shadowLayer.color.cgColor
            self.layer.shadowOpacity = shadowLayer.opacity
            self.layer.shadowOffset = shadowLayer.offset
            self.layer.shadowRadius = shadowLayer.radius
            self.layer.masksToBounds = false
        }
    }
}

extension ButtonStyleType {
    var titleFont: UIFont { return UIFont.systemFont(ofSize: 17) }
    var tintColor: UIColor { return .sandDune }
    var titleColorNormal: UIColor? { return nil }
    var titleColorHighlighted: UIColor? { return nil }
    var cornerRadius: CGFloat { return 0 }
    var backgroundColor: UIColor? { return nil }
    var contentInsets: UIEdgeInsets { return .zero }
    var borderColor: UIColor? { return nil }
    var borderWidth: CGFloat { return 0  }
    var shadowLayer: ButtonShadowLayer? { return nil }
}

struct ButtonShadowLayer {
    let color: UIColor
    let opacity: Float
    let offset: CGSize
    let radius: CGFloat
}
