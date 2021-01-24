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
    var starImage: UIImage? {get}
    var highlightedStarImage: UIImage? {get}
}

struct BeersListItemStyle: BeersListItemStyleType {
    var beerNameTextStyle: LabelStyleType {
        return LabelStyle(
            textFont: .systemFont(ofSize: 16, weight: .medium),
            textColor: .mineShaft)
    }
    var beerTaglineTextStyle: LabelStyleType {
        return LabelStyle(
            textFont: .systemFont(ofSize: 16, weight: .regular),
            textColor: .mineShaft)
    }
    var starImage: UIImage? {
        return UIImage(named: "star_ic")?
            .withTintColor(UIColor.sandDune.withAlphaComponent(0.7))
    }
    var highlightedStarImage: UIImage? {
        return UIImage(named: "star_highlighted_ic")
    }
}
