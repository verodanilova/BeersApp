//
//  UIColor+Extensions.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import UIKit


extension UIColor {
    convenience init(int: UInt32, alpha: Float = 1) {
        self.init(red: CGFloat((int & 0xFF0000) >> 16) / 255,
            green: CGFloat((int & 0x00FF00) >> 8) / 255,
            blue: CGFloat((int & 0x0000FF)) / 255, alpha: CGFloat(alpha))
    }
    
    var hex: String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
}
