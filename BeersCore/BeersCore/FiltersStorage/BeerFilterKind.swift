//
//  BeerFilterKind.swift
//  BeersCore
//
//  Created by Veronica Danilova on 20.03.2021.
//

public enum BeerFilterKind {
    case alcoholLowerValue
    case alcoholUpperValue
    case bitternessLowerValue
    case bitternessUpperValue
    case colorLowerValue
    case colorUpperValue
    
    public var edgeValue: Double {
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
