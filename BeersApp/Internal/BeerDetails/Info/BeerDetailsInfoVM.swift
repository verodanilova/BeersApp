//
//  BeerDetailsInfoViewModel.swift
//  BeersApp
//
//  Created by Veronica Danilova on 07.11.2020.
//

import Foundation
import RxSwift
import RxCocoa
import BeersCore


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
        
        let configurator = BeerDetailsConfigurator()
        self.alcoholUnit = info.map(configurator.makeAlcoholUnit)
        self.bitternessUnit = info.map(configurator.makeBitternessUnit)
        self.colorKind = info.map { $0.colorKind }
    }
}
