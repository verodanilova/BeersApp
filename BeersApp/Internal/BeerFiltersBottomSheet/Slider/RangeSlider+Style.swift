//
//  RangeSlider+Style.swift
//  BeersApp
//
//  Created by Veronica Danilova on 09.11.2020.
//

import UIKit


protocol RangeSliderStyleType {
    var trackTintColor: UIColor {get}
    var trackHighlightTintColor: UIColor {get}
    var thumbTintColor: UIColor {get}
    var thumbHighlightTintColor: UIColor {get}
    var thumbBorderColor: UIColor {get}
}

extension RangeSlider {
    func apply(style: RangeSliderStyleType) {
        self.trackTintColor = style.trackTintColor
        self.trackHighlightTintColor = style.trackHighlightTintColor
        self.thumbTintColor = style.thumbTintColor
        self.thumbHighlightTintColor = style.thumbHighlightTintColor
        self.thumbBorderColor = style.thumbBorderColor
    }
}

struct RangeSliderStyle: RangeSliderStyleType {
    var trackTintColor: UIColor
    var trackHighlightTintColor: UIColor
    var thumbTintColor: UIColor
    var thumbHighlightTintColor: UIColor
    var thumbBorderColor: UIColor
}
