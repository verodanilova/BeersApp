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
    var alcoholUnit: Driver<String?> {get}
    var bitternessUnit: Driver<String?> {get}
    var colorUnit: Driver<String?> {get}
}

final class BeerDetailsInfoViewModel: BeerDetailsInfoViewModelType {
    let title: Driver<String?>
    let tagline: Driver<String?>
    let description: Driver<String?>
    let alcoholUnit: Driver<String?>
    let bitternessUnit: Driver<String?>
    let colorUnit: Driver<String?>
    
    init(info: Driver<BeerInfo>) {
        self.title = info.map { $0.name }
        self.tagline = info.map { $0.tagline }
        self.description = info.map { $0.beerDescription }
        
        let configurator = Configurator()
        self.alcoholUnit = info.map(configurator.makeAlcoholUnit)
        self.bitternessUnit = info.map(configurator.makeBitternessUnit)
        self.colorUnit = info.map(configurator.makeColorUnit)
    }
}

private struct Configurator {
    func makeAlcoholUnit(from beerInfo: BeerInfo) -> String? {
        let format = NSLocalizedString(
            "Beer details.Info.Figures.Alcohol.Format",
            comment: "Beer details info: alcohol index format")
        return String(format: format, "\(beerInfo.alcoholIndex)")
    }
    
    func makeBitternessUnit(from beerInfo: BeerInfo) -> String? {
        let format = NSLocalizedString(
            "Beer details.Info.Figures.Bitterness.Format",
            comment: "Beer details info: bitterness index format")
        return String(format: format, "\(beerInfo.bitternessIndex)")
    }
    
    func makeColorUnit(from beerInfo: BeerInfo) -> String? {
        let format = NSLocalizedString(
            "Beer details.Info.Figures.Color.Format",
            comment: "Beer details info: color index format")
        return String(format: format, "\(beerInfo.colorIndex)")
    }
}
