//
//  BeerListBaseHeaderStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 02.04.2021.
//

import UIKit


protocol BeerListBaseHeaderStyleType {
    var headerBackgroundColor: UIColor {get}
    var titleLabelStyle: LabelStyleType {get}
}

struct BeerListBaseHeaderStyle: BeerListBaseHeaderStyleType {
    var headerBackgroundColor: UIColor {
        .white
    }
    var titleLabelStyle: LabelStyleType {
        LabelStyle(
            textFont: .bold(ofSize: 28),
            textColor: .mineShaft)
    }
}
