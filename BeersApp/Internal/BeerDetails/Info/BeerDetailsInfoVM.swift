//
//  BeerDetailsInfoViewModel.swift
//  BeersApp
//
//  Created by Veronica Danilova on 07.11.2020.
//

import Foundation
import RxSwift
import RxCocoa


protocol BeerDetailsInfoViewModelType {
    var title: Driver<String?> {get}
    var tagline: Driver<String?> {get}
    var description: Driver<String?> {get}
    var alcoholUnit: Driver<String> {get}
    var bitternessUnit: Driver<String> {get}
    var colorKind: Driver<BeerColorKind> {get}
}

final class BeerDetailsInfoViewModel: BeerDetailsInfoViewModelType {
    let title: Driver<String?>
    let tagline: Driver<String?>
    let description: Driver<String?>
    let alcoholUnit: Driver<String>
    let bitternessUnit: Driver<String>
    let colorKind: Driver<BeerColorKind>
    
    init(info: Driver<BeerInfo>) {
        self.title = info.map { $0.name }
        self.tagline = info.map { $0.tagline }
        self.description = info.map { $0.beerDescription }
        
        let configurator = Configurator()
        self.alcoholUnit = info.map(configurator.makeAlcoholUnit)
        self.bitternessUnit = info.map(configurator.makeBitternessUnit)
        self.colorKind = info.map { $0.colorKind }
    }
}

private struct Configurator {
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
