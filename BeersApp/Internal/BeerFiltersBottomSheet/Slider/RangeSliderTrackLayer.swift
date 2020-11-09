//
//  RangeSliderTrackLayer.swift
//  BeersApp
//
//  Created by Veronica Danilova on 09.11.2020.
//

import UIKit

class RangeSliderTrackLayer: CALayer {
    
    weak var rangeSlider: RangeSlider?
    
    override func draw(in context: CGContext) {
        guard let slider = rangeSlider else {
            return
        }
        
        // Clip
        let cornerRadius = bounds.height * 0.5
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        context.addPath(path.cgPath)
        
        // Fill the track
        context.setFillColor(slider.trackTintColor.cgColor)
        context.addPath(path.cgPath)
        context.fillPath()
        
        // Fill the highlighted range
        context.setFillColor(slider.trackHighlightTintColor.cgColor)
        let lowerValuePosition = CGFloat(slider.positionForValue(slider.lowerValue))
        let upperValuePosition = CGFloat(slider.positionForValue(slider.upperValue))
        let rect = CGRect(x: lowerValuePosition, y: 0.0, width: upperValuePosition - lowerValuePosition, height: bounds.height)
        context.fill(rect)
    }
}
