//
//  BeersListHeaderView.swift
//  BeersApp
//
//  Created by Veronica Danilova on 11.11.2020.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


private struct Constants {
    let separatorInsets: CGFloat = 16
    let inset: CGFloat = 24
    let separatorHeight: CGFloat = 1
}
private let constants = Constants()

final class BeersListHeaderView: UIView {
    
    var resetButtonTap: Signal<Void> {
        return resetButton.rx.tap.asSignal()
    }
    
    private let textLabel = UILabel()
    private let resetButton = UIButton()
    private let separatorView = UIView()
    
    var style: BeersListHeaderStyleType? {
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
private extension BeersListHeaderView {
    func commonInit() {
        resetButton.setTitle(NSLocalizedString(
            "Beers list.Header.Reset button.Title",
            comment: "Beers list header: title for reset button"), for: .normal)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(resetButton)
        resetButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(constants.inset)
            $0.centerY.equalToSuperview()
        }
        
        textLabel.text = NSLocalizedString(
            "Beers list.Header.Filter info.Title",
            comment: "Beers list header: filters info text")
        textLabel.numberOfLines = 0
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(constants.inset)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(resetButton.snp.leading).inset(constants.inset)
        }
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(constants.separatorInsets)
            $0.height.equalTo(constants.separatorHeight)
        }
    }
    
    func applyStyle() {
        guard let style = style else { return }
        backgroundColor = style.headerBackgroundColor
        textLabel.apply(style: style.filtersInfoTextStyle)
        resetButton.apply(style: style.resetButtonStyle)
        separatorView.backgroundColor = style.separatorColor
    }
}
