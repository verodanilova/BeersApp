//
//  BeerFiltersStorage.swift
//  BeersCore
//
//  Created by Veronica Danilova on 20.03.2021.
//

import Foundation


public final class BeerFiltersStorage: BeerFiltersStorageType {
    public var alcoholLowerValue: Double?
    public var alcoholUpperValue: Double?
    public var bitternessLowerValue: Double?
    public var bitternessUpperValue: Double?
    public var colorLowerValue: Double?
    public var colorUpperValue: Double?
    
    public var hasSelectedFilters: Bool {
        let allValues = [
            alcoholLowerValue, alcoholUpperValue,
            bitternessLowerValue, bitternessUpperValue,
            colorLowerValue, colorUpperValue
        ]
        return allValues.contains(where: { $0 != nil })
    }
    
    public init() {}
    
    public func setValue(_ value: Double, for filterKind: BeerFilterKind) {
        let edgeValue = filterKind.edgeValue
        let newValue = value == edgeValue ? nil : value
        
        switch filterKind {
            case .alcoholLowerValue:
                alcoholLowerValue = newValue
            case .alcoholUpperValue:
                alcoholUpperValue = newValue
            case .bitternessLowerValue:
                bitternessLowerValue = newValue
            case .bitternessUpperValue:
                bitternessUpperValue = newValue
            case .colorLowerValue:
                colorLowerValue = newValue
            case .colorUpperValue:
                colorUpperValue = newValue
        }
    }
    
    public func resetFilters() {
        alcoholLowerValue = nil
        alcoholUpperValue = nil
        bitternessLowerValue = nil
        bitternessUpperValue = nil
        colorLowerValue = nil
        colorUpperValue = nil
    }
}
