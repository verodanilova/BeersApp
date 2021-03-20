//
//  BeerDetailsInfoView.swift
//  BeersApp
//
//  Created by Veronica Danilova on 07.11.2020.
//

import UIKit
import RxSwift
import RxCocoa
import BeersCore


class BeerDetailsInfoView: UIView {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var taglineLabel: UILabel!
    
    /* Figures block */
    @IBOutlet private var topSeparatorView: UIView!
    @IBOutlet private var alcoholTitleLabel: UILabel!
    @IBOutlet private var alcoholVolumeLabel: UILabel!
    @IBOutlet private var bitternessTitleLabel: UILabel!
    @IBOutlet private var bitternessIndexLabel: UILabel!
    @IBOutlet private var colorTitleLabel: UILabel!
    @IBOutlet private var colorValueView: UIView!
    @IBOutlet private var bottomSeparatorView: UIView!
    
    /* Description block */
    @IBOutlet private var aboutTitleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!

    
    var style: BeerDetailsInfoStyleType? {
        didSet { applyStyle() }
    }
    
    var viewModel: BeerDetailsInfoViewModelType? {
        didSet { bindViewModel() }
    }
    
    private let disposeBag = DisposeBag()
}

private extension BeerDetailsInfoView {
    func applyStyle() {
        guard let style = style else { return }
        
        backgroundColor = style.infoBackgroundColor
        titleLabel.apply(style: style.titleLabelStyle)
        taglineLabel.apply(style: style.taglineLabelStyle)
        aboutTitleLabel.apply(style: style.sectionTitleLabelStyle)
        aboutTitleLabel.text = NSLocalizedString(
            "Beer details.Info.About.Title",
            comment: "Beer details info: About title")
        descriptionLabel.apply(style: style.sectionTextLabelStyle)
        topSeparatorView.backgroundColor = style.separatorViewColor
        alcoholTitleLabel.apply(style: style.figuresTitleLabelStyle)
        alcoholTitleLabel.text = NSLocalizedString(
            "Beer details.Info.Figures.Alcohol.Title",
            comment: "Beer details info: Alcohol figure title")
        alcoholVolumeLabel.apply(style: style.figuresIndexLabelStyle)
        bitternessTitleLabel.apply(style: style.figuresTitleLabelStyle)
        bitternessTitleLabel.text = NSLocalizedString(
            "Beer details.Info.Figures.Bitterness.Title",
            comment: "Beer details info: Bitterness figure title")
        bitternessIndexLabel.apply(style: style.figuresIndexLabelStyle)
        colorTitleLabel.apply(style: style.figuresTitleLabelStyle)
        colorTitleLabel.text = NSLocalizedString(
            "Beer details.Info.Figures.Color.Title",
            comment: "Beer details info: Color figure title")
        bottomSeparatorView.backgroundColor = style.separatorViewColor
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        let disposables: [Disposable] = [
            viewModel.title.drive(titleLabel.rx.text),
            viewModel.tagline.drive(taglineLabel.rx.text),
            viewModel.description.drive(descriptionLabel.rx.text),
            viewModel.alcoholUnit.drive(alcoholVolumeLabel.rx.text),
            viewModel.bitternessUnit.drive(bitternessIndexLabel.rx.text)
        ]
        disposables.forEach { $0.disposed(by: disposeBag) }
        
        viewModel.colorKind
            .drive(onNext: weakly(self, type(of: self).setColorKind))
            .disposed(by: disposeBag)
    }
    
    func setColorKind(_ colorKind: BeerColorKind) {
        guard let style = style else { return }
        
        colorValueView.subviews.forEach { $0.removeFromSuperview() }
        
        if colorKind == .unknown {
            let placeholderLabel = UILabel()
            placeholderLabel.text = NSLocalizedString(
                "Beer details.Info.Figures.Placeholder",
                comment: "Beer details info: placeholder format")
            placeholderLabel.textAlignment = .center
            placeholderLabel.apply(style: style.figuresIndexLabelStyle)
            colorValueView.layer.borderWidth = 0
            colorValueView.addSubview(placeholderLabel)
            placeholderLabel.snp.makeConstraints { $0.edges.equalToSuperview() }
        } else {
            colorValueView.apply(style: style.colorValueViewStyle)
            colorValueView.backgroundColor = style.colorForBeerColorKind(colorKind)
        }
    }
}
