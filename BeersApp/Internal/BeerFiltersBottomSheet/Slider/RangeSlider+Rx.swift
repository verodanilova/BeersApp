//
//  RangeSlider+Rx.swift
//  BeersApp
//
//  Created by Veronica Danilova on 10.11.2020.
//

import RxSwift
import RxCocoa


extension Reactive where Base: RangeSlider {
    var minimumValue: Binder<Double> {
        return Binder(self.base) { view, value in
            view.minimumValue = value
        }
    }
    
    var maximumValue: Binder<Double> {
        return Binder(self.base) { view, value in
            view.maximumValue = value
        }
    }
    
    var lowerValue: ControlProperty<Double> {
        return base.rx.controlProperty(
            editingEvents: [.valueChanged],
            getter: { control in
                control.lowerValue
            }, setter: { control, value in
                control.lowerValue = value
            }
        )
    }
    
    var upperValue: ControlProperty<Double> {
        return base.rx.controlProperty(
            editingEvents: [.valueChanged],
            getter: { control in
                control.upperValue
            }, setter: { control, value in
                control.upperValue = value
            }
        )
    }
    
    var values: Driver<(lowerValue: Double, upperValue: Double)> {
        Driver.combineLatest(lowerValue.asDriver(), upperValue.asDriver())
            .map { (lowerValue: $0, upperValue: $1) }
    }
}

