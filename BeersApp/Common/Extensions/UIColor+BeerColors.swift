//
//  UIColor+BeerColors.swift
//  BeersApp
//
//  Created by Veronica Danilova on 27.03.2021.
//

import UIKit
import BeersCore

extension UIColor {
    static func color(for beerColorKind: BeerColorKind) -> UIColor? {
        switch beerColorKind {
            case .paleStraw: return beerColors.paleStraw
            case .straw: return beerColors.straw
            case .paleGold: return beerColors.paleGold
            case .deepGold: return beerColors.deepGold
            case .paleAmber: return beerColors.paleAmber
            case .mediumAmber: return beerColors.mediumAmber
            case .deepAmber: return beerColors.deepAmber
            case .amberBrown: return beerColors.amberBrown
            case .brown: return beerColors.brown
            case .rubyBrown: return beerColors.rubyBrown
            case .deepBrown: return beerColors.deepBrown
            case .black: return beerColors.black
            case .unknown: return nil
        }
    }
}
