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
            textFont: .bold(ofSize: 24),
            textColor: .freshEggplant)
    }

    var unitLabelStyle: LabelStyleType {
        return LabelStyle(
            textFont: .semibold(ofSize: 20),
            textColor: .mineShaft)
    }
    
    var sliderStyle: RangeSliderStyleType {
        return RangeSliderStyle(
            trackTintColor: .albescentWhite,
            trackHighlightTintColor: .grainBrown,
            thumbTintColor: .white,
            thumbHighlightTintColor: .freshEggplant,
            thumbBorderColor: .grainBrown)
    }
    
    var activeValueInfoLabelStyle: LabelStyleType {
        return LabelStyle(
            textFont: .semibold(ofSize: 18),
            textColor: .white)
    }
    
    var activeValueInfoContainerStyle: ViewStyle {
        return ViewStyle(cornerRadius: 14, borderWidth: 1,
            borderColor: .freshEggplant, backgroundColor: .freshEggplant)
    }
    
    var inactiveValueInfoLabelStyle: LabelStyleType {
        return LabelStyle(
            textFont: .regular(ofSize: 18),
            textColor: .sandDune)
    }
    
    var inactiveValueInfoContainerStyle: ViewStyle {
        return ViewStyle(cornerRadius: 14, borderWidth: 1,
            borderColor: .swirl, backgroundColor: .white)
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
        return 22
    }
    var backgroundColor: UIColor? {
        return UIColor.freshEggplant.withAlphaComponent(0.9)
    }
    var borderColor: UIColor? {
        return .freshEggplant
    }
    var borderWidth: CGFloat {
        return 2
    }
    var contentInsets: UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
    }
}
