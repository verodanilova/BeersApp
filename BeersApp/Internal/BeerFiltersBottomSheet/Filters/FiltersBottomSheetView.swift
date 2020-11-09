//
//  FiltersBottomSheetView.swift
//  BeersApp
//
//  Created by Veronica Danilova on 09.11.2020.
//

import UIKit

class FiltersBottomSheetView: BottomSheetContentView {
    
    @IBOutlet private var panView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var separatorView: UIView!
    
    @IBOutlet private var alcoholUnitLabel: UILabel!
    @IBOutlet private var alcoholRangeSlider: RangeSlider!
    
    @IBOutlet private var bitternessUnitLabel: UILabel!
    @IBOutlet private var bitternessRangeSlider: RangeSlider!
    
    @IBOutlet private var colorUnitLabel: UILabel!
    @IBOutlet private var colorRangeSlider: RangeSlider!
    
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
        
    }
}
