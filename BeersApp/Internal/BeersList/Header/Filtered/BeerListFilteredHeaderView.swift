//
//  BeerListFilteredHeaderView.swift
//  BeersApp
//
//  Created by Veronica Danilova on 02.04.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import BeersCore


private struct Constants {
    let separatorInsets: CGFloat = 16
    let inset: CGFloat = 16
    let separatorHeight: CGFloat = 1
}
private let constants = Constants()

typealias HeaderFilters = [FilterType: String]

final class BeerListFilteredHeaderView: UIView {
    
    weak var delegate: BeerListHeaderDelegate?
    
    var filtersTap: Signal<Void> {
        filtersButton.rx.tap.asSignal()
    }
    
    var resetButtonTap: Signal<Void> {
        resetButton.rx.tap.asSignal()
    }
    
    var resetFilterTap: Signal<FilterType> {
        resetFilterRelay.asSignal()
    }
    
    private let titleLabel = UILabel()
    private let filtersButton = FiltersButton()
    private let resetButton = UIButton()
    private let verticalStackView = UIStackView()
    private let separatorView = UIView()
    private let resetFilterRelay = PublishRelay<FilterType>()
    
    private var chips: [UIView] = []
    private var disposeBag = DisposeBag()
    
    var style: BeerListFilteredHeaderStyleType? {
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
    
    func configure(with filters: HeaderFilters) {
        disposeBag = DisposeBag()
        updateChips(for: filters)
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setChips()
        delegate?.updateHeaderSize()
    }
}

// MARK: - Configuration
private extension BeerListFilteredHeaderView {
    func commonInit() {
        resetButton.setTitle(NSLocalizedString(
            "Beers list.Header.Reset button.Title",
            comment: "Beers list header: title for reset button"), for: .normal)

        addSubview(filtersButton)
        filtersButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().priority(750)
        }

        titleLabel.text = NSLocalizedString(
            "Beers list.Header.Filter info.Title",
            comment: "Beers list header: filters info text")
            .uppercased()
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(constants.inset)
            $0.top.equalToSuperview().priority(750)
            $0.trailing.equalTo(filtersButton.snp.leading)
        }

        verticalStackView.axis = .vertical
        verticalStackView.alignment = .leading
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 16
        
        addSubview(verticalStackView)
        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(constants.inset)
        }

        addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.top.equalTo(verticalStackView.snp.bottom).offset(constants.inset)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(constants.separatorInsets)
            $0.height.equalTo(constants.separatorHeight)
        }
    }
    
    func applyStyle() {
        guard let style = style else { return }
        backgroundColor = style.headerBackgroundColor
        titleLabel.apply(style: style.filteredTitleTextStyle)
        resetButton.apply(style: style.resetButtonStyle)
        separatorView.backgroundColor = style.separatorColor
    }
}

// MARK: - Filters chips
private extension BeerListFilteredHeaderView {
    func updateChips(for filters: HeaderFilters) {
        let sortedFilters = filters.sorted { $0.key.rawValue < $1.key.rawValue }
        chips = sortedFilters.compactMap { makeChip(with: $0.value, type: $0.key) }
        if chips.count > 1 {
            chips.append(resetButton)
        }
    }
    
    func makeChip(with title: String, type: FilterType) -> UIView? {
        guard let style = style else { return nil }

        let chipView = UIView()
        
        let closeButton = UIButton()
        chipView.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalTo(closeButton.snp.height)
        }
        closeButton.apply(style: style.closeButtonStyle)

        let textLabel = UILabel()
        textLabel.text = title
        chipView.addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(constants.inset)
            $0.trailing.equalTo(closeButton.snp.leading)
        }
        
        textLabel.apply(style: style.chipTextStyle)
        chipView.apply(style: style.chipViewStyle)
        
        closeButton.rx.tap
            .map { _ in type }
            .bind(to: resetFilterRelay)
            .disposed(by: disposeBag)

        return chipView
    }
    
    func setChips() {

        verticalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        var chipsGroups: [[UIView]] = []
        let containerWidth = verticalStackView.frame.width
        
        chips.forEach { chip in

            if var lastGroup = chipsGroups.last {
                let elementsCount = lastGroup.count
                var groupWidth = lastGroup.map({ $0.frame.width }).reduce(0, +)
                groupWidth += 8 * CGFloat(elementsCount)
                
                if groupWidth + chip.frame.width < containerWidth {
                    lastGroup.append(chip)
                    chipsGroups[chipsGroups.endIndex - 1] = lastGroup
                } else {
                    var newGroup: [UIView] = []
                    newGroup.append(chip)
                    chipsGroups.append(newGroup)
                }
            } else {
                var newGroup: [UIView] = []
                newGroup.append(chip)
                chipsGroups.append(newGroup)
            }
        }

        for group in chipsGroups {
            let horizontalStackView = UIStackView()
            horizontalStackView.axis = .horizontal
            horizontalStackView.alignment = .fill
            horizontalStackView.distribution = .equalSpacing
            horizontalStackView.spacing = 8
            
            verticalStackView.addArrangedSubview(horizontalStackView)
            
            horizontalStackView.snp.makeConstraints { view in
                view.height.equalTo(40)
            }
            
            group.forEach { horizontalStackView.addArrangedSubview($0) }
        }

        layoutIfNeeded()
    }
}
