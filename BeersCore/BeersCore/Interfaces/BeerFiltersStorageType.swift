//
//  BeerFiltersStorageType.swift
//  BeersCore
//
//  Created by Veronica Danilova on 20.03.2021.
//

public protocol BeerFiltersStorageType: AnyObject {
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
