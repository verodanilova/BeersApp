//
//  FiltersButton.swift
//  BeersApp
//
//  Created by Veronica Danilova on 02.04.2021.
//

import UIKit

final class FiltersButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}

private extension FiltersButton {
    func commonInit() {
        let title = NSLocalizedString(
            "Beers list.Filters button.Title",
            comment: "Beers list: filters button title")
        setTitle(title, for: .normal)
        apply(style: FiltersButtonStyle())
        setupLeftImage()
    }
    
    func setupLeftImage() {
        let image = UIImage(named: "filters_ic")?
            .withRenderingMode(.automatic)
            .withTintColor(.freshEggplant)
        setImage(image, for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 6, left: -8, bottom: 2, right: 0)
        contentHorizontalAlignment = .left
        imageView?.contentMode = .scaleAspectFit
    }
}

private struct FiltersButtonStyle: ButtonStyleType {
    var titleFont: UIFont {
        return .semibold(ofSize: 20)
    }
    var titleColorNormal: UIColor? {
        return .freshEggplant
    }
    var titleColorHighlighted: UIColor? {
        return .purple
    }
    var contentInsets: UIEdgeInsets {
        UIEdgeInsets(top: 6, left: 8, bottom: 8, right: 8)
    }
}
