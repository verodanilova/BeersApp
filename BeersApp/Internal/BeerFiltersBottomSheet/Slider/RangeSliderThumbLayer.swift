//
//  RangeSliderThumbLayer.swift
//  BeersApp
//
//  Created by Veronica Danilova on 09.11.2020.
//

import UIKit


class RangeSliderThumbLayer: CALayer {
    
    weak var rangeSlider: RangeSlider?
    
    var strokeColor: UIColor = UIColor.gray {
        didSet {
            setNeedsDisplay()
        }
    }
    var lineWidth: CGFloat = 0.5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var highlighted: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(in context: CGContext) {
        guard let slider = rangeSlider else {
            return
        }
        
        let thumbFrame = bounds
        let cornerRadius = thumbFrame.height * 0.5
        let thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: cornerRadius)
        
        // Fill
        context.setFillColor(slider.thumbTintColor.cgColor)
        context.addPath(thumbPath.cgPath)
        context.fillPath()
        
        // Outline
        context.setStrokeColor(strokeColor.cgColor)
        context.setLineWidth(lineWidth)
        context.addPath(thumbPath.cgPath)
        context.strokePath()
        
        if highlighted {
            context.setFillColor(slider.thumbHighlightTintColor.cgColor)
            context.addPath(thumbPath.cgPath)
            context.fillPath()
        }
    }
}
