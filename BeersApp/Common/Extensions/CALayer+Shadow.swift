//
//  CALayer+Shadow.swift
//  BeersApp
//
//  Created by Veronica Danilova on 08.11.2020.
//

import UIKit


struct LayerShadow {
    let color: UIColor
    let opacity: Float
    let offset: CGSize
    let radius: CGFloat
}

extension CALayer {
    func addShadow(_ shadow: LayerShadow) {
        shadowColor = shadow.color.cgColor
        shadowOpacity = shadow.opacity
        shadowOffset = shadow.offset
        shadowRadius = shadow.radius
        masksToBounds = false
    }
}

