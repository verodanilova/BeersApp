//
//  BeerDetailsConfigurator.swift
//  BeersApp
//
//  Created by Veronica Danilova on 27.03.2021.
//

import Foundation
import BeersCore

struct BeerDetailsConfigurator {
    private let valueFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.allowsFloats = true
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        return formatter
    }()
    
    private let placeholder = NSLocalizedString(
        "Beer details.Info.Figures.Placeholder",
        comment: "Beer details info: placeholder format")
    
    func makeAlcoholUnit(from beerInfo: BeerInfo) -> String {
        guard beerInfo.alcoholIndex > 0 else {
            return placeholder
        }

        let format = NSLocalizedString(
            "Beer details.Info.Figures.Alcohol.Volume.Format",
            comment: "Beer details info: alcohol index format")
        let index = NSNumber(value: beerInfo.alcoholIndex)
        guard let indexString = valueFormatter.string(from: index) else {
            return placeholder
        }
        return String(format: format, indexString)
    }
    
    func makeBitternessUnit(from beerInfo: BeerInfo) -> String {
        guard beerInfo.bitternessIndex > 0 else {
            return placeholder
        }
        
        let index = NSNumber(value: beerInfo.bitternessIndex)
        return valueFormatter.string(from: index) ?? placeholder
    }
}
