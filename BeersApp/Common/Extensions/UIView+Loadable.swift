//
//  UIView+Loadable.swift
//  BeersApp
//
//  Created by Veronica Danilova on 07.11.2020.
//

import UIKit


extension UIView {
    static func loadFromNib() -> Self {
        let `class` = self
        let bundle = Bundle(for: `class`)
        let named = String(describing: `class`)
        return loadFromNib(named: named, bundle: bundle)
    }
    
    static func loadFromNib<T>(named: String, bundle: Bundle = .main) -> T {
        return bundle.loadNibNamed(named, owner: nil, options: nil)?.first! as! T
    }
}

