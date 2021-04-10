//
//  UIFont+AppFonts.swift
//  BeersApp
//
//  Created by Veronica Danilova on 27.03.2021.
//

import UIKit

private enum AppFont: String {
    case regular = "CrimsonText-Roman"
    case italic = "CrimsonText-Italic"
    case semibold = "CrimsonText-Semibold"
    case semiboldItalic = "CrimsonText-SemiboldItalic"
    case bold = "CrimsonText-Bold"
    case boldItalic = "CrimsonText-BoldItalic"
}

extension UIFont {
    
    static func regular(ofSize size: CGFloat) -> UIFont {
        UIFont.appFont(.regular, size: size)
    }
    
    static func italic(ofSize size: CGFloat) -> UIFont {
        UIFont.appFont(.italic, size: size)
    }
    
    static func semibold(ofSize size: CGFloat) -> UIFont {
        UIFont.appFont(.semibold, size: size)
    }
    
    static func semiboldItalic(ofSize size: CGFloat) -> UIFont {
        UIFont.appFont(.semiboldItalic, size: size)
    }
    
    static func bold(ofSize size: CGFloat) -> UIFont {
        UIFont.appFont(.bold, size: size)
    }
    
    static func boldItalic(ofSize size: CGFloat) -> UIFont {
        UIFont.appFont(.boldItalic, size: size)
    }
}

private extension UIFont {
    
    static func appFont(_ type: AppFont, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: type.rawValue, size: size) else {
            fatalError("Failed to load the \(type.rawValue) font.")
        }
        return font
    }
}
