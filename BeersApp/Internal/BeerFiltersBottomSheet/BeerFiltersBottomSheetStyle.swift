//
//  BeerFiltersBottomSheetStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 08.11.2020.
//

import UIKit


protocol BeerFiltersBottomSheetStyleType {
    var backgroundColor: UIColor {get}
    var panViewStyle: ViewStyle {get}
    var titleLabelStyle: LabelStyleType {get}
    var separatorColor: UIColor {get}
    var unitLabelStyle: LabelStyleType {get}
    var sliderStyle: RangeSliderStyleType {get}
    var activeValueInfoLabelStyle: LabelStyleType {get}
    var activeValueInfoContainerStyle: ViewStyle {get}
    var inactiveValueInfoLabelStyle: LabelStyleType {get}
    var inactiveValueInfoContainerStyle: ViewStyle {get}
    var applyButtonStyle: ButtonStyleType {get}
}

struct BeerFiltersBottomSheetStyle: BeerFiltersBottomSheetStyleType {
    var backgroundColor: UIColor {
        return .white
    }
    
    var panViewStyle: ViewStyle {
        return ViewStyle(cornerRadius: 3,
            backgroundColor: UIColor.alto.withAlphaComponent(0.6))
    }
    
    var titleLabelStyle: LabelStyleType {
        return LabelStyle(
            textFont: .systemFont(ofSize: 18, weight: .medium),
            textColor: .mineShaft)
    }
    
    var separatorColor: UIColor {
        return .alto
    }
    
    var unitLabelStyle: LabelStyleType {
        return LabelStyle(
            textFont: .systemFont(ofSize: 16, weight: .semibold),
            textColor: .mineShaft)
    }
    
    var sliderStyle: RangeSliderStyleType {
        return RangeSliderStyle(
            trackTintColor: .alto,
            trackHighlightTintColor: .bostonBlue,
            thumbTintColor: .white,
            thumbHighlightTintColor: .bostonBlue,
            thumbBorderColor: .bostonBlue)
    }
    
    var activeValueInfoLabelStyle: LabelStyleType {
        return LabelStyle(
            textFont: .systemFont(ofSize: 16, weight: .medium),
            textColor: .white)
    }
    
    var activeValueInfoContainerStyle: ViewStyle {
        return ViewStyle(cornerRadius: 14, borderWidth: 1,
            borderColor: .bostonBlue, backgroundColor: .bostonBlue)
    }
    
    var inactiveValueInfoLabelStyle: LabelStyleType {
        return LabelStyle(
            textFont: .systemFont(ofSize: 16, weight: .regular),
            textColor: .sandDune)
    }
    
    var inactiveValueInfoContainerStyle: ViewStyle {
        return ViewStyle(cornerRadius: 14, borderWidth: 1,
            borderColor: .alto, backgroundColor: .white)
    }

    var applyButtonStyle: ButtonStyleType {
        return ApplyButtonStyle()
    }
}

private struct ApplyButtonStyle: ButtonStyleType {
    var titleColorNormal: UIColor? {
        return .white
    }
    var titleColorHighlighted: UIColor? {
        return .white
    }
    var cornerRadius: CGFloat {
        return 6
    }
    var backgroundColor: UIColor? {
        return UIColor.salem.withAlphaComponent(0.9)
    }
    var borderColor: UIColor? {
        return .salem
    }
    var borderWidth: CGFloat {
        return 2
    }
}
