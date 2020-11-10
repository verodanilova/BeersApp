//
//  BeerFiltersStorage.swift
//  BeersApp
//
//  Created by Veronica Danilova on 10.11.2020.
//

import Foundation


protocol BeerFiltersStorageType: AnyObject {
    var alcoholLowerValue: Double? {get}
    var alcoholUpperValue: Double? {get}
    var bitternessLowerValue: Double? {get}
    var bitternessUpperValue: Double? {get}
    var colorLowerValue: Double? {get}
    var colorUpperValue: Double? {get}
    
    var hasSelectedFilters: Bool {get}
    
    func setValue(_ value: Double, for filterKind: BeerFilterKind)
    func resetFilters()
}

class BeerFiltersStorage: BeerFiltersStorageType {
    var alcoholLowerValue: Double?
    var alcoholUpperValue: Double?
    var bitternessLowerValue: Double?
    var bitternessUpperValue: Double?
    var colorLowerValue: Double?
    var colorUpperValue: Double?
    
    var hasSelectedFilters: Bool {
        let allValues = [
            alcoholLowerValue, alcoholUpperValue,
            bitternessLowerValue, bitternessUpperValue,
            colorLowerValue, colorUpperValue
        ]
        return allValues.contains(where: { $0 != nil })
    }
    
    init() {}
    
    func setValue(_ value: Double, for filterKind: BeerFilterKind) {
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
    
    func resetFilters() {
        alcoholLowerValue = nil
        alcoholUpperValue = nil
        bitternessLowerValue = nil
        bitternessUpperValue = nil
        colorLowerValue = nil
        colorUpperValue = nil
    }
}
