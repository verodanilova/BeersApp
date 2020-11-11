//
//  FiltersBottomSheetView.swift
//  BeersApp
//
//  Created by Veronica Danilova on 09.11.2020.
//

import UIKit
import RxSwift
import RxCocoa


class FiltersBottomSheetView: BottomSheetContentView {
    
    @IBOutlet private var panView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var separatorView: UIView!
    
    @IBOutlet private var alcoholUnitLabel: UILabel!
    @IBOutlet private var alcoholRangeSlider: RangeSlider!
    @IBOutlet private var alcoholRangeInfoContainerView: UIView!
    @IBOutlet private var alcoholRangeInfoLabel: UILabel!
    
    @IBOutlet private var bitternessUnitLabel: UILabel!
    @IBOutlet private var bitternessRangeSlider: RangeSlider!
    @IBOutlet private var bitternessRangeInfoContainerView: UIView!
    @IBOutlet private var bitternessRangeInfoLabel: UILabel!
    
    @IBOutlet private var colorUnitLabel: UILabel!
    @IBOutlet private var colorRangeSlider: RangeSlider!
    @IBOutlet private var colorRangeInfoContainerView: UIView!
    @IBOutlet private var colorRangeInfoLabel: UILabel!

    @IBOutlet private var applyButton: UIButton!
    
    weak var delegate: BottomSheetContentViewDelegate?
    
    var viewModel: BeerFiltersBottomSheetViewModelType? {
        didSet {
            bindViewModel()
        }
    }
    
    var style: BeerFiltersBottomSheetStyleType? {
        didSet {
            applyStyle()
            configureViewComponents()
        }
    }
    
    private let disposeBag = DisposeBag()
}

// MARK: - View configuration
private extension FiltersBottomSheetView {
    func applyStyle() {
        guard let style = style else { return }
        
        backgroundColor = style.backgroundColor
        panView.apply(style: style.panViewStyle)
        titleLabel.apply(style: style.titleLabelStyle)
        separatorView.backgroundColor = style.separatorColor
        alcoholUnitLabel.apply(style: style.unitLabelStyle)
        alcoholRangeSlider.apply(style: style.sliderStyle)
        bitternessUnitLabel.apply(style: style.unitLabelStyle)
        bitternessRangeSlider.apply(style: style.sliderStyle)
        colorUnitLabel.apply(style: style.unitLabelStyle)
        colorRangeSlider.apply(style: style.sliderStyle)
        applyButton.apply(style: style.applyButtonStyle)
    }
    
    func configureViewComponents() {
        titleLabel.text = NSLocalizedString(
            "Beers list.Filters.Title",
            comment: "Beers list filters: title")
        alcoholUnitLabel.text = NSLocalizedString(
            "Beers list.Filters.Alcohol index.Title",
            comment: "Beers list filters: alcohol unit label text")
        bitternessUnitLabel.text = NSLocalizedString(
            "Beers list.Filters.Bitterness index.Title",
            comment: "Beers list filters: bitterness unit label text")
        colorUnitLabel.text = NSLocalizedString(
            "Beers list.Filters.Color index.Title",
            comment: "Beers list filters: color unit label text")
            
        let buttonTitle = NSLocalizedString(
            "Beers list.Filters.Apply button.Title",
            comment: "Beers list filters: title for apply button")
        applyButton.setTitle(buttonTitle, for: .normal)
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        alcoholRangeSlider.minimumValue = viewModel.alcoholEdgesRange.minimum
        alcoholRangeSlider.maximumValue = viewModel.alcoholEdgesRange.maximum
        alcoholRangeSlider.lowerValue = viewModel.alcoholValuesRange.lowerValue
        alcoholRangeSlider.upperValue = viewModel.alcoholValuesRange.upperValue
        
        bitternessRangeSlider.minimumValue = viewModel.bitternessEdgesRange.minimum
        bitternessRangeSlider.maximumValue = viewModel.bitternessEdgesRange.maximum
        bitternessRangeSlider.lowerValue = viewModel.bitternessValuesRange.lowerValue
        bitternessRangeSlider.upperValue = viewModel.bitternessValuesRange.upperValue
        
        colorRangeSlider.minimumValue = viewModel.colorEdgesRange.minimum
        colorRangeSlider.maximumValue = viewModel.colorEdgesRange.maximum
        colorRangeSlider.lowerValue = viewModel.colorValuesRange.lowerValue
        colorRangeSlider.upperValue = viewModel.colorValuesRange.upperValue
        
        viewModel.alcoholValuesInfo
            .drive(alcoholRangeInfoLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.alcoholFilterIsActive
            .drive(onNext: { [weak self] isActive in
                self?.changeActiveState(isActive, of: self?.alcoholRangeInfoLabel)
            })
            .disposed(by: disposeBag)
        
        viewModel.bitternessValuesInfo
            .drive(bitternessRangeInfoLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.bitternessFilterIsActive
            .drive(onNext: { [weak self] isActive in
                self?.changeActiveState(isActive, of: self?.bitternessRangeInfoLabel)
            })
            .disposed(by: disposeBag)
        
        viewModel.colorValuesInfo
            .drive(colorRangeInfoLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.colorFilterIsActive
            .drive(onNext: { [weak self] isActive in
                self?.changeActiveState(isActive, of: self?.colorRangeInfoLabel)
            })
            .disposed(by: disposeBag)
        
        viewModel.bindViewEvents(
            alcoholValuesRange: alcoholRangeSlider.rx.values,
            bitternessValuesRange: bitternessRangeSlider.rx.values,
            colorValuesRange: colorRangeSlider.rx.values,
            applyTap: applyButton.rx.tap.asSignal())
        
        applyButton.rx.tap.asDriver()
            .drive(onNext: weakly(self, type(of: self).applyButtonTapped))
            .disposed(by: disposeBag)
    }
    
    func changeActiveState(_ isActive: Bool, of valueLabel: UILabel?) {
        guard let style = style, let label = valueLabel else { return }
        
        if isActive {
            label.apply(style: style.activeValueInfoLabelStyle)
            label.superview?.apply(style: style.activeValueInfoContainerStyle)
        } else {
            label.apply(style: style.inactiveValueInfoLabelStyle)
            label.superview?.apply(style: style.inactiveValueInfoContainerStyle)
        }
    }
    
    func applyButtonTapped() {
        delegate?.contentViewDidFinishInteraction()
    }
}
