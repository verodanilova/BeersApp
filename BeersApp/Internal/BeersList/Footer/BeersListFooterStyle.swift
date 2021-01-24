//
//  BeersListFooterStyle.swift
//  BeersApp
//
//  Created by Veronica Danilova on 07.11.2020.
//

import UIKit


protocol BeersListFooterStyleType {
    var footerBackgroundColor: UIColor {get}
    var activityIndicatorStyle: UIActivityIndicatorView.Style {get}
    var footerTextStyle: LabelStyle {get}
}

struct BeersListFooterStyle: BeersListFooterStyleType {
    var footerBackgroundColor: UIColor {
        return .white
    }
    var activityIndicatorStyle: UIActivityIndicatorView.Style {
        return .medium
    }
    var footerTextStyle: LabelStyle {
        return LabelStyle(
            textFont: .systemFont(ofSize: 16, weight: .regular),
            textColor: .sandDune)
    }
}
