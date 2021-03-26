//
//  BeerDetailsFoodPairingView.swift
//  BeersApp
//
//  Created by Veronica Danilova on 22.03.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

private struct Constants {
    static let titleOffset: CGFloat = 16
    static let verticalStackViewOffset: CGFloat = 16
    static let chipsEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    static let chipsOffset: CGFloat = 8
    static let chipsHeight: CGFloat = 36
}

class BeerDetailsFoodPairingView: UIView {

    var style: BeerDetailsFoodPairingStyleType? {
        didSet { applyStyle() }
    }
    
    var viewModel: BeerDetailsFoodPairingViewModelType? {
        didSet { bindViewModel() }
    }
    
    private let titleLabel = UILabel()
    private let verticalStackView = UIStackView()
    private let bottomOverscrollView = UIView()
    private var chips: [UIButton] = []
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setChips()
    }
}

// MARK: - View configuration
private extension BeerDetailsFoodPairingView {
    func configureView() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(Constants.titleOffset)
        }
        titleLabel.text = NSLocalizedString(
            "Beer details.Food pairing.Title",
            comment: "Beer details food pairing: title")
        
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .leading
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = Constants.verticalStackViewOffset
        
        addSubview(verticalStackView)
        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.titleOffset)
            $0.leading.trailing.equalToSuperview().inset(Constants.verticalStackViewOffset)
            $0.bottom.equalToSuperview().inset(Constants.verticalStackViewOffset * 2)
        }
        
        addSubview(bottomOverscrollView)
        bottomOverscrollView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(snp.bottom)
            $0.height.equalTo(UIScreen.main.bounds.height)
        }
    }
    
    func applyStyle() {
        guard let style = style else { return }
        backgroundColor = style.pairingBackgroundColor
        bottomOverscrollView.backgroundColor = style.pairingBackgroundColor
        titleLabel.apply(style: style.titleLabelStyle)
    }
    
    func makeChip(with title: String, index: Int) -> UIButton? {
        guard let style = style else { return nil }
        
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        button.apply(style: style.chipStyle)
        button.contentEdgeInsets = Constants.chipsEdgeInsets
        button.tag = index
        button.sizeToFit()
        return button
    }
    
    func setChips() {
        verticalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        var chipsGroups: [[UIButton]] = []
        let containerWidth = verticalStackView.frame.width
        chips.forEach { chip in
            if var lastGroup = chipsGroups.last {
                let elementsCount = lastGroup.count
                var groupWidth = lastGroup.map({ $0.frame.width }).reduce(0, +)
                groupWidth += Constants.chipsOffset * CGFloat(elementsCount)
                
                if groupWidth + chip.frame.width < containerWidth {
                    lastGroup.append(chip)
                    chipsGroups[chipsGroups.endIndex - 1] = lastGroup
                } else {
                    var newGroup: [UIButton] = []
                    newGroup.append(chip)
                    chipsGroups.append(newGroup)
                }
            } else {
                var newGroup: [UIButton] = []
                newGroup.append(chip)
                chipsGroups.append(newGroup)
            }
        }
        
        for group in chipsGroups {
            let horizontalStackView = UIStackView()
            horizontalStackView.axis = .horizontal
            horizontalStackView.alignment = .fill
            horizontalStackView.distribution = .equalSpacing
            horizontalStackView.spacing = Constants.chipsOffset
            
            verticalStackView.addArrangedSubview(horizontalStackView)
            
            horizontalStackView.snp.makeConstraints { view in
                view.height.equalTo(Constants.chipsHeight)
            }
            
            group.forEach { horizontalStackView.addArrangedSubview($0) }
        }
        
        layoutIfNeeded()
    }
}

// MARK: - View model binding
private extension BeerDetailsFoodPairingView {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.foodPairings
            .drive(onNext: { [weak self] slots in
                self?.makeChips(with: slots)
                self?.makeButtonsBindings()
            })
            .disposed(by: disposeBag)
    }
    
    func makeChips(with foodPairings: [String]) {
        chips = foodPairings.enumerated().compactMap { index, title in
            makeChip(with: title, index: index)
        }
    }
    
    func makeButtonsBindings() {
        guard let viewModel = viewModel else { return }
        
        let tapEventsWithIndices = chips.map { button in
            button.rx.tap.asDriver().map { button.tag }
        }
        viewModel.bindViewEvents(chipTapped: Driver.merge(tapEventsWithIndices))
        
        Driver.merge(tapEventsWithIndices)
            .drive(onNext: { [weak self] _ in self?.feedbackGenerator.impactOccurred() })
            .disposed(by: disposeBag)
    }
}
