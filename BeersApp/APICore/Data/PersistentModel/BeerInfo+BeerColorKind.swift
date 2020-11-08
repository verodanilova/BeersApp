//
//  BeerInfo+BeerColorKind.swift
//  BeersApp
//
//  Created by Veronica Danilova on 08.11.2020.
//

import Foundation


enum BeerColorKind {
    case paleStraw
    case straw
    case paleGold
    case deepGold
    case paleAmber
    case mediumAmber
    case deepAmber
    case amberBrown
    case brown
    case rubyBrown
    case deepBrown
    case black
    case unknown
}

extension BeerInfo {
    var colorKind: BeerColorKind {
        switch self.colorIndex {
            case 4.0..<6.0: return .paleStraw
            case 6.0..<8.0: return .straw
            case 8.0..<12.0: return .paleGold
            case 12.0..<18.0: return .deepGold
            case 18.0..<24.0: return .paleAmber
            case 24.0..<30.0: return .mediumAmber
            case 30.0..<35.0: return .deepAmber
            case 35.0..<39.0: return .amberBrown
            case 39.0..<47.0: return .brown
            case 47.0..<59.0: return .rubyBrown
            case 59.0..<79.0: return .deepBrown
            case 79.0...: return .black
            default: return .unknown
        }
    }
}
