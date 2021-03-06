//
//  BeerFiltersBottomSheetViewModel.swift
//  BeersApp
//
//  Created by Veronica Danilova on 08.11.2020.
//

import Foundation
import RxSwift
import RxCocoa
import BeersCore


protocol BeerFiltersBottomSheetViewModelType {
    typealias UnitEdgesRange = (minimum: Double, maximum: Double)
    typealias UnitValuesRange = (lowerValue: Double, upperValue: Double)
    
    var alcoholEdgesRange: UnitEdgesRange {get}
    var bitternessEdgesRange: UnitEdgesRange {get}
    var colorEdgesRange: UnitEdgesRange {get}
    
    var alcoholValuesRange: UnitValuesRange {get}
    var bitternessValuesRange: UnitValuesRange {get}
    var colorValuesRange: UnitValuesRange {get}
    
    var alcoholValuesInfo: Driver<String> {get}
    var alcoholFilterIsActive: Driver<Bool> {get}
    var bitternessValuesInfo: Driver<String> {get}
    var bitternessFilterIsActive: Driver<Bool> {get}
    var colorValuesInfo: Driver<String> {get}
    var colorFilterIsActive: Driver<Bool> {get}
    
    func bindViewEvents(alcoholValuesRange: Driver<UnitValuesRange>,
        bitternessValuesRange: Driver<UnitValuesRange>,
        colorValuesRange: Driver<UnitValuesRange>, applyTap: Signal<Void>)
}

final class BeerFiltersBottomSheetViewModel: BeerFiltersBottomSheetViewModelType {
    let alcoholEdgesRange: UnitEdgesRange
    let bitternessEdgesRange: UnitEdgesRange
    let colorEdgesRange: UnitEdgesRange
    let alcoholValuesRange: UnitValuesRange
    let bitternessValuesRange: UnitValuesRange
    let colorValuesRange: UnitValuesRange
    
    let alcoholValuesInfo: Driver<String>
    let alcoholFilterIsActive: Driver<Bool>
    private let alcoholValuesRangeRelay: BehaviorRelay<UnitValuesRange>
    
    let bitternessValuesInfo: Driver<String>
    let bitternessFilterIsActive: Driver<Bool>
    private let bitternessValuesRangeRelay: BehaviorRelay<UnitValuesRange>
    
    let colorValuesInfo: Driver<String>
    let colorFilterIsActive: Driver<Bool>
    private let colorValuesRangeRelay: BehaviorRelay<UnitValuesRange>
    
    private let storage: BeerFiltersStorageType
    private weak var delegate: BeerFiltersBottomSheetDelegate?
    private let disposeBag = DisposeBag()
    
    init(storage: BeerFiltersStorageType, delegate: BeerFiltersBottomSheetDelegate) {
        self.storage = storage
        self.delegate = delegate
        
        let configurator = Configurator()
        self.alcoholEdgesRange = configurator.getAlcoholEdgesRange()
        self.bitternessEdgesRange = configurator.getBitternessEdgesRange()
        self.colorEdgesRange = configurator.getColorEdgesRange()
        
        self.alcoholValuesRange = configurator.getAlcoholValuesRange(in: storage)
        self.alcoholValuesRangeRelay = BehaviorRelay(value: alcoholValuesRange)
        self.alcoholFilterIsActive = alcoholValuesRangeRelay.asDriver()
            .map(configurator.isAlcoholFilterActive)
        self.alcoholValuesInfo = alcoholValuesRangeRelay.asDriver()
            .map(configurator.makeAlcoholRangeInfo)
        
        self.bitternessValuesRange = configurator.getBitternessValuesRange(in: storage)
        self.bitternessValuesRangeRelay = BehaviorRelay(value: bitternessValuesRange)
        self.bitternessFilterIsActive = bitternessValuesRangeRelay.asDriver()
            .map(configurator.isBitternessFilterActive(valuesRange:))
        self.bitternessValuesInfo = bitternessValuesRangeRelay.asDriver()
            .map(configurator.makeBitternessRangeInfo)
        
        self.colorValuesRange = configurator.getColorValuesRange(in: storage)
        self.colorValuesRangeRelay = BehaviorRelay(value: colorValuesRange)
        self.colorFilterIsActive = colorValuesRangeRelay.asDriver()
            .map(configurator.isColorFilterActive)
        self.colorValuesInfo = colorValuesRangeRelay.asDriver()
            .map(configurator.makeColorRangeInfo)
    }
    
    func bindViewEvents(alcoholValuesRange: Driver<UnitValuesRange>,
        bitternessValuesRange: Driver<UnitValuesRange>,
        colorValuesRange: Driver<UnitValuesRange>, applyTap: Signal<Void>) {
        alcoholValuesRange
            .drive(onNext: weakly(self, type(of: self).setAlcoholValuesRange))
            .disposed(by: disposeBag)
        
        bitternessValuesRange
            .drive(onNext: weakly(self, type(of: self).setBitternessValuesRange))
            .disposed(by: disposeBag)
        
        colorValuesRange
            .drive(onNext: weakly(self, type(of: self).setColorValuesRange))
            .disposed(by: disposeBag)
        
        applyTap
            .emit(onNext: weakly(self, type(of: self).applyFilters))
            .disposed(by: disposeBag)
    }
}

// MARK: - Actions
private extension BeerFiltersBottomSheetViewModel {
    func setAlcoholValuesRange(_ range: UnitValuesRange) {
        alcoholValuesRangeRelay.accept(range)
        storage.setValue(range.lowerValue, for: .alcoholLowerValue)
        storage.setValue(range.upperValue, for: .alcoholUpperValue)
    }
    
    func setBitternessValuesRange(_ range: UnitValuesRange) {
        bitternessValuesRangeRelay.accept(range)
        storage.setValue(range.lowerValue, for: .bitternessLowerValue)
        storage.setValue(range.upperValue, for: .bitternessUpperValue)
    }
    
    func setColorValuesRange(_ range: UnitValuesRange) {
        colorValuesRangeRelay.accept(range)
        storage.setValue(range.lowerValue, for: .colorLowerValue)
        storage.setValue(range.upperValue, for: .colorUpperValue)
    }
    
    func applyFilters() {
        delegate?.shouldApplyFilters()
    }
}

// MARK: - Configurator
private struct Configurator {
    private let valueFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.allowsFloats = true
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        return formatter
    }()
    
    func getAlcoholEdgesRange() -> (minimum: Double, maximum: Double) {
        let minimum = BeerFilterKind.alcoholLowerValue.edgeValue
        let maximum = BeerFilterKind.alcoholUpperValue.edgeValue
        return (minimum: minimum, maximum: maximum)
    }
    
    func getBitternessEdgesRange() -> (minimum: Double, maximum: Double) {
        let minimum = BeerFilterKind.bitternessLowerValue.edgeValue
        let maximum = BeerFilterKind.bitternessUpperValue.edgeValue
        return (minimum: minimum, maximum: maximum)
    }
    
    func getColorEdgesRange() -> (minimum: Double, maximum: Double) {
        let minimum = BeerFilterKind.colorLowerValue.edgeValue
        let maximum = BeerFilterKind.colorUpperValue.edgeValue
        return (minimum: minimum, maximum: maximum)
    }
    
    func getAlcoholValuesRange(in storage: BeerFiltersStorageType)
        -> (lowerValue: Double, upperValue: Double) {
        
        let defaultLowerValue = BeerFilterKind.alcoholLowerValue.edgeValue
        let defaultUpperValue = BeerFilterKind.alcoholUpperValue.edgeValue
        
        let lowerValue = storage.alcoholLowerValue ?? defaultLowerValue
        let upperValue = storage.alcoholUpperValue ?? defaultUpperValue
        
        return (lowerValue: lowerValue, upperValue: upperValue)
    }
    
    func getBitternessValuesRange(in storage: BeerFiltersStorageType)
        -> (lowerValue: Double, upperValue: Double) {
        
        let defaultLowerValue = BeerFilterKind.bitternessLowerValue.edgeValue
        let defaultUpperValue = BeerFilterKind.bitternessUpperValue.edgeValue
        
        let lowerValue = storage.bitternessLowerValue ?? defaultLowerValue
        let upperValue = storage.bitternessUpperValue ?? defaultUpperValue
        
        return (lowerValue: lowerValue, upperValue: upperValue)
    }
    
    func getColorValuesRange(in storage: BeerFiltersStorageType)
        -> (lowerValue: Double, upperValue: Double) {
        
        let defaultLowerValue = BeerFilterKind.colorLowerValue.edgeValue
        let defaultUpperValue = BeerFilterKind.colorUpperValue.edgeValue
        
        let lowerValue = storage.colorLowerValue ?? defaultLowerValue
        let upperValue = storage.colorUpperValue ?? defaultUpperValue
        
        return (lowerValue: lowerValue, upperValue: upperValue)
    }
    
    func isAlcoholFilterActive(valuesRange: (lowerValue: Double, upperValue: Double)) -> Bool {
        let (minimum, maximum) = getAlcoholEdgesRange()
        return !(valuesRange.lowerValue == minimum && valuesRange.upperValue == maximum)
    }
    
    func makeAlcoholRangeInfo(for valuesRange: (lowerValue: Double, upperValue: Double)) -> String {
        let (lower, upper) = valuesRange
        let (minimum, maximum) = getAlcoholEdgesRange()

        if lower == minimum && upper == maximum {
            return NSLocalizedString(
                "Beers list.Filters.Alcohol index info.All",
                comment: "Beers filters: alcohol index info for all volumes")
        } else if lower > minimum && upper == maximum {
            let lowerValue = valueFormatter.string(from: NSNumber(value: lower)) ?? ""
            let format = NSLocalizedString(
                "Beers list.Filters.Alcohol index info.From",
                comment: "Beers filters: alcohol index info for volumes from set value")
            return String(format: format, lowerValue)
        } else if upper < maximum && lower == minimum {
            let upperValue = valueFormatter.string(from: NSNumber(value: upper)) ?? ""
            let format = NSLocalizedString(
                "Beers list.Filters.Alcohol index info.To",
                comment: "Beers filters: alcohol index info for volumes to set value")
            return String(format: format, upperValue)
        } else {
            let lowerValue = valueFormatter.string(from: NSNumber(value: lower)) ?? ""
            let upperValue = valueFormatter.string(from: NSNumber(value: upper)) ?? ""
            let format = NSLocalizedString(
                "Beers list.Filters.Alcohol index info.From-To",
                comment: "Beers filters: alcohol index info for range of values")
            return String(format: format, lowerValue, upperValue)
        }
    }
    
    func isBitternessFilterActive(valuesRange: (lowerValue: Double, upperValue: Double)) -> Bool {
        let (minimum, maximum) = getBitternessEdgesRange()
        return !(valuesRange.lowerValue == minimum && valuesRange.upperValue == maximum)
    }
    
    func makeBitternessRangeInfo(for valuesRange: (lowerValue: Double, upperValue: Double)) -> String {
        let (lower, upper) = valuesRange
        let format = NSLocalizedString(
            "Beers list.Filters.Bitterness index info.From-To",
            comment: "Beers filters: bitterness index info")
        return String(format: format, Int(lower), Int(upper))
    }
    
    func isColorFilterActive(valuesRange: (lowerValue: Double, upperValue: Double)) -> Bool {
        let (minimum, maximum) = getColorEdgesRange()
        return !(valuesRange.lowerValue == minimum && valuesRange.upperValue == maximum)
    }
    
    func makeColorRangeInfo(for valuesRange: (lowerValue: Double, upperValue: Double)) -> String {
        let (lower, upper) = valuesRange
        let (minimum, maximum) = getColorEdgesRange()

        if lower == minimum && upper == maximum {
            return NSLocalizedString(
                "Beers list.Filters.Color index info.All",
                comment: "Beers filters: color index info for all colors")
        } else if lower > minimum && upper == maximum {
            let format = NSLocalizedString(
                "Beers list.Filters.Color index info.From",
                comment: "Beers filters: color index info for volumes from set value")
            return String(format: format, Int(lower))
        } else if upper < maximum && lower == minimum {
            let format = NSLocalizedString(
                "Beers list.Filters.Color index info.To",
                comment: "Beers filters: color index info for volumes to set value")
            return String(format: format, Int(upper))
        } else {
            let format = NSLocalizedString(
                "Beers list.Filters.Color index info.From-To",
                comment: "Beers filters: color index info for range of values")
            return String(format: format, Int(lower), Int(upper))
        }
    }
}
