//
//  BeersListFooterView.swift
//  BeersApp
//
//  Created by Veronica Danilova on 07.11.2020.
//

import UIKit
import SnapKit


private struct Constants {
    let offset: CGFloat = 16
}
private let constants = Constants()

final class BeersListFooterView: UIView {
    
    private let textLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView()
    
    var style: BeersListFooterStyleType? {
        didSet { applyStyle() }
    }
    
    var isInitialLoading: Bool = true {
        didSet { updateText() }
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
private extension BeersListFooterView {
    func commonInit() {
        textLabel.numberOfLines = 0
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(constants.offset)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-constants.offset)
        }
        updateText()

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.top.equalToSuperview().offset(constants.offset)
            $0.trailing.equalTo(textLabel.snp.leading).offset(-constants.offset)
            $0.bottom.equalToSuperview().offset(-constants.offset)
        }
        activityIndicator.startAnimating()
    }
    
    func applyStyle() {
        guard let style = style else { return }
        backgroundColor = style.footerBackgroundColor
        activityIndicator.style = style.activityIndicatorStyle
        textLabel.apply(style: style.footerTextStyle)
    }
    
    func updateText() {
        if isInitialLoading {
            textLabel.text = NSLocalizedString(
                "Beers list.Footer.Initial loading.Title",
                comment: "Text for initial loading in Beers List footer")
        } else {
            textLabel.text = NSLocalizedString(
                "Beers list.Footer.Loading more info.Title",
                comment: "Text for loading more info in Beers List footer")
        }
    }
}
