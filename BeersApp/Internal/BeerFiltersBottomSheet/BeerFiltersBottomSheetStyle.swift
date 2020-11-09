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
    var applyButtonStyle: ButtonStyleType {get}
}

struct BeerFiltersBottomSheetStyle: BeerFiltersBottomSheetStyleType {
    var backgroundColor: UIColor {
        return appColors.white
    }
    
    var panViewStyle: ViewStyle {
        return ViewStyle(cornerRadius: 3,
            backgroundColor: appColors.alto.withAlphaComponent(0.6))
    }
    
    var titleLabelStyle: LabelStyleType {
        return LabelStyle(
            textFont: .systemFont(ofSize: 18, weight: .medium),
            textColor: appColors.mineShaft)
    }
    
    var separatorColor: UIColor {
        return appColors.alto
    }
    
    var unitLabelStyle: LabelStyleType {
        return LabelStyle(
            textFont: .systemFont(ofSize: 16, weight: .semibold),
            textColor: appColors.mineShaft)
    }
    
    var sliderStyle: RangeSliderStyleType {
        return RangeSliderStyle(
            trackTintColor: appColors.alto,
            trackHighlightTintColor: appColors.bostonBlue,
            thumbTintColor: appColors.white,
            thumbHighlightTintColor: appColors.bostonBlue,
            thumbBorderColor: appColors.bostonBlue)
    }
    
    var applyButtonStyle: ButtonStyleType {
        return ApplyButtonStyle()
    }
}

private struct ApplyButtonStyle: ButtonStyleType {
    var titleColorNormal: UIColor? {
        return appColors.white
    }
    var titleColorHighlighted: UIColor? {
        return appColors.white
    }
    var cornerRadius: CGFloat {
        return 6
    }
    var backgroundColor: UIColor? {
        return appColors.salem.withAlphaComponent(0.9)
    }
    var borderColor: UIColor? {
        return appColors.salem
    }
    var borderWidth: CGFloat {
        return 2
    }
}
