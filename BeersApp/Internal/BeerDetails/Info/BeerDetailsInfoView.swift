//
//  BeerDetailsInfoView.swift
//  BeersApp
//
//  Created by Veronica Danilova on 07.11.2020.
//

import UIKit
import RxSwift
import RxCocoa


class BeerDetailsInfoView: UIView {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var taglineLabel: UILabel!
    @IBOutlet private var aboutTitleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var figuresLabel: UILabel!
    @IBOutlet private var alcoholLabel: UILabel!
    @IBOutlet private var bitternessLabel: UILabel!
    @IBOutlet private var colorLabel: UILabel!
    
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
        figuresLabel.apply(style: style.sectionTitleLabelStyle)
        figuresLabel.text = NSLocalizedString(
            "Beer details.Info.Figures.Title",
            comment: "Beer details info: Figures title")
        alcoholLabel.apply(style: style.sectionTextLabelStyle)
        bitternessLabel.apply(style: style.sectionTextLabelStyle)
        colorLabel.apply(style: style.sectionTextLabelStyle)
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        let disposables: [Disposable] = [
            viewModel.title.drive(titleLabel.rx.text),
            viewModel.tagline.drive(taglineLabel.rx.text),
            viewModel.description.drive(descriptionLabel.rx.text),
            viewModel.alcoholUnit.drive(alcoholLabel.rx.text),
            viewModel.bitternessUnit.drive(bitternessLabel.rx.text),
            viewModel.colorUnit.drive(colorLabel.rx.text)
        ]
        disposables.forEach { $0.disposed(by: disposeBag) }
    }
}
