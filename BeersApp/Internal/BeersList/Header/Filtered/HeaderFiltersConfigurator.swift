//
//  HeaderFiltersConfigurator.swift
//  BeersApp
//
//  Created by Veronica Danilova on 10.04.2021.
//

import Foundation
import BeersCore

struct HeaderFiltersConfigurator {
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.allowsFloats = true
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        return formatter
    }()
    
    let storage: BeerFiltersStorageType
    
    var hasAlcoholFilter: Bool {
        storage.alcoholLowerValue != nil || storage.alcoholUpperValue != nil
    }
    
    var hasBitternessFilter: Bool {
        storage.bitternessLowerValue != nil || storage.bitternessUpperValue != nil
    }
    
    var hasColorFilter: Bool {
        storage.colorLowerValue != nil || storage.colorUpperValue != nil
    }
    
    var alcoholValue: String {
        standardFormat(from: storage.alcoholLowerValue,
                       to: storage.alcoholUpperValue)
    }
    
    var bitternessValue: String {
        standardFormat(from: storage.bitternessLowerValue,
                       to: storage.bitternessUpperValue)
    }
    
    var colorValue: String {
        colorFormat(from: storage.colorLowerValue, to: storage.colorUpperValue)
    }
}

private extension HeaderFiltersConfigurator {
    func standardFormat(from lower: Double?, to upper: Double?) -> String {
        if let lower = lower, let upper = upper,
           let lowerValue = formatter.string(from: NSNumber(value: lower)),
           let upperValue = formatter.string(from: NSNumber(value: upper)) {
            return "\(lowerValue) - \(upperValue)"
        }
        else if let lower = lower,
            let lowerValue = formatter.string(from: NSNumber(value: lower)) {
            return "> \(lowerValue)"
        }
        else if let upper = upper,
            let upperValue = formatter.string(from: NSNumber(value: upper)) {
            return "< \(upperValue)"
        }
        else {
            return ""
        }
    }
    
    func colorFormat(from lower: Double?, to upper: Double?) -> String {
        if let lowerValue = lower, let upperValue = upper {
            let from = BeerColorKind(for: lowerValue).rawValue
            let to = BeerColorKind(for: upperValue).rawValue
            return "\(from) - \(to)"
        }
        else if let lowerValue = lower {
            let format = NSLocalizedString(
                "Beers list.Header.Filters.Color.Darker",
                comment: "Beers list filters header: darker color format")
            return String(format: format, BeerColorKind(for: lowerValue).rawValue)
        }
        else if let upperValue = upper {
            let format = NSLocalizedString(
                "Beers list.Header.Filters.Color.Lighter",
                comment: "Beers list filters header: lighter color format")
            return String(format: format, BeerColorKind(for: upperValue).rawValue)
        }
        else {
            return ""
        }
    }
}
