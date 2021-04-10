//
//  BeerInfo+BeerColorKind.swift
//  BeersApp
//
//  Created by Veronica Danilova on 08.11.2020.
//

import Foundation


public enum BeerColorKind: String {
    case paleStraw = "pale straw"
    case straw = "straw"
    case paleGold = "pale gold"
    case deepGold = "deep gold"
    case paleAmber = "pale amber"
    case mediumAmber = "medium amber"
    case deepAmber = "deep amber"
    case amberBrown = "amber brown"
    case brown = "brown"
    case rubyBrown = "ruby brown"
    case deepBrown = "deep brown"
    case black = "black"
    case unknown
    
    public init(for colorIndex: Double) {
        switch colorIndex {
            case 4.0..<6.0: self = .paleStraw
            case 6.0..<8.0: self = .straw
            case 8.0..<12.0: self = .paleGold
            case 12.0..<18.0: self = .deepGold
            case 18.0..<24.0: self = .paleAmber
            case 24.0..<30.0: self = .mediumAmber
            case 30.0..<35.0: self = .deepAmber
            case 35.0..<39.0: self = .amberBrown
            case 39.0..<47.0: self = .brown
            case 47.0..<59.0: self = .rubyBrown
            case 59.0..<79.0: self = .deepBrown
            case 79.0...: self = .black
            default: self = .unknown
        }
    }
}

public extension BeerInfo {
    var colorKind: BeerColorKind {
        BeerColorKind(for: self.colorIndex)
    }
}
