//
//  BeersListItemStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 02.11.2020.
//

import UIKit


protocol BeersListItemStyleType {
    var beerNameTextStyle: LabelStyleType {get}
    var beerTaglineTextStyle: LabelStyleType {get}
}

struct BeersListItemStyle: BeersListItemStyleType {
    var beerNameTextStyle: LabelStyleType {
        return LabelStyle(
            textFont: .systemFont(ofSize: 16, weight: .medium),
            textColor: appColors.sandDune)
    }
    var beerTaglineTextStyle: LabelStyleType {
        return LabelStyle(
            textFont: .systemFont(ofSize: 16, weight: .regular),
            textColor: appColors.sandDune)
    }
}
