//
//  BeerListBaseHeaderView.swift
//  BeersApp
//
//  Created by Veronica Danilova on 02.04.2021.
//

import UIKit

final class BeerListBaseHeaderView: UIView {
    
    let filtersButton = FiltersButton()
    private let titleLabel = UILabel()
    
    var style: BeerListBaseHeaderStyleType? {
        didSet { applyStyle() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}

// MARK: - Configuration
private extension BeerListBaseHeaderView {
    func commonInit() {

        addSubview(filtersButton)
        filtersButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().priority(750)
        }

        titleLabel.numberOfLines = 0
        titleLabel.text = NSLocalizedString(
            "Beers list.Title", comment: "Beers list: title")
            .uppercased()
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(filtersButton.snp.leading)
            $0.bottom.equalToSuperview().inset(8)
            $0.top.equalToSuperview().priority(750)
        }
        
    }

    func applyStyle() {
        guard let style = style else { return }
        backgroundColor = style.headerBackgroundColor
        titleLabel.apply(style: style.titleLabelStyle)
    }
}
