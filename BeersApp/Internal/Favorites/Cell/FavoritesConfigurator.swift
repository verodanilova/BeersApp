//
//  FavoritesConfigurator.swift
//  BeersApp
//
//  Created by Veronica Danilova on 27.03.2021.
//

import Foundation

struct FavoritesConfigurator {
    private let valueFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.allowsFloats = true
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        return formatter
    }()
    
    private let placeholder = NSLocalizedString(
        "Favorites.Beer Info.Figures.Placeholder",
        comment: "Beer info: placeholder format")
    
    func makeAlcoholUnit(from beer: BeerListItem) -> String {
        guard beer.alcoholIndex > 0 else {
            return placeholder
        }

        let format = NSLocalizedString(
            "Favorites.Beer Info.Figures.Alcohol.Volume.Format",
            comment: "Beer info: alcohol index format")
        let index = NSNumber(value: beer.alcoholIndex)
        guard let indexString = valueFormatter.string(from: index) else {
            return placeholder
        }
        return String(format: format, indexString)
    }
    
    func makeBitternessUnit(from beer: BeerListItem) -> String {
        guard beer.bitternessIndex > 0 else {
            return placeholder
        }
        
        let index = NSNumber(value: beer.bitternessIndex)
        return valueFormatter.string(from: index) ?? placeholder
    }
}

