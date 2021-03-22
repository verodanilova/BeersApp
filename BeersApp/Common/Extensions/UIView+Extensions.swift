//
//  UIView+Extensions.swift
//  BeersApp
//
//  Created by Veronica Danilova on 22.03.2021.
//

import UIKit

extension UIView {
    
    private static let shimmerLayerName = "shimmerLayer"
    
    func startShimmering() {
        self.layoutIfNeeded()
        
        let gradientGray = UIColor(white: 0.85, alpha: 1.0).cgColor
        let gradientGrayLight = UIColor(white: 0.95, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = UIView.shimmerLayerName
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [gradientGray, gradientGrayLight, gradientGray]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        layer.addSublayer(gradientLayer)
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 1
        gradientLayer.add(animation, forKey: animation.keyPath)
    }
    
    func stopShimmering() {
        let shimmerLayers = layer.sublayers?
            .filter { $0.name == UIView.shimmerLayerName }
        shimmerLayers?.forEach { $0.removeFromSuperlayer() }
    }
}
