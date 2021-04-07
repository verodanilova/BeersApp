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
    
    /* Image */
    var image: ButtonImage? {get}
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
            self.applyShadowLayer(shadowLayer)
        }
        
        if let buttonImage = style.image {
            self.applyImage(buttonImage)
        }
    }
}

private extension UIButton {
    
    func applyShadowLayer(_ shadowLayer: ButtonShadowLayer) {
        self.layer.shadowColor = shadowLayer.color.cgColor
        self.layer.shadowOpacity = shadowLayer.opacity
        self.layer.shadowOffset = shadowLayer.offset
        self.layer.shadowRadius = shadowLayer.radius
        self.layer.masksToBounds = false
    }
    
    func applyImage(_ buttonImage: ButtonImage) {
        let image = UIImage(named: buttonImage.name)?
            .withRenderingMode(buttonImage.renderingMode)
            .withTintColor(buttonImage.tintColor)
        self.setImage(image, for: .normal)
        self.imageEdgeInsets = buttonImage.insets
        self.contentHorizontalAlignment = buttonImage.horizontalAlignment
        self.imageView?.contentMode = buttonImage.contentMode
    }
}

extension ButtonStyleType {
    var titleFont: UIFont { return .regular(ofSize: 20) }
    var tintColor: UIColor { return .sandDune }
    var titleColorNormal: UIColor? { return nil }
    var titleColorHighlighted: UIColor? { return nil }
    var cornerRadius: CGFloat { return 0 }
    var backgroundColor: UIColor? { return nil }
    var contentInsets: UIEdgeInsets { return .zero }
    var borderColor: UIColor? { return nil }
    var borderWidth: CGFloat { return 0  }
    var shadowLayer: ButtonShadowLayer? { return nil }
    var image: ButtonImage? { return nil }
}

struct ButtonShadowLayer {
    let color: UIColor
    let opacity: Float
    let offset: CGSize
    let radius: CGFloat
}

struct ButtonImage {
    let name: String
    let renderingMode: UIImage.RenderingMode
    let tintColor: UIColor
    let insets: UIEdgeInsets
    let horizontalAlignment: UIControl.ContentHorizontalAlignment
    let contentMode: UIView.ContentMode
}
