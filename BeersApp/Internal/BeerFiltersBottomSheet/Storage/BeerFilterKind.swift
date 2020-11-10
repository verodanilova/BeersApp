//
//  BeerFilterKind.swift
//  BeersApp
//
//  Created by Veronica Danilova on 10.11.2020.
//

import Foundation


enum BeerFilterKind {
    case alcoholLowerValue
    case alcoholUpperValue
    case bitternessLowerValue
    case bitternessUpperValue
    case colorLowerValue
    case colorUpperValue
    
    var edgeValue: Double {
        switch self {
            case .alcoholLowerValue: return 0.0
            case .alcoholUpperValue: return 42.0
            case .bitternessLowerValue: return 0.0
            case .bitternessUpperValue: return 120.0
            case .colorLowerValue: return 4.0
            case .colorUpperValue: return 79.0
        }
    }
}
