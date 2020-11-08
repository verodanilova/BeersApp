//
//  BeerDetailsViewController.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


private struct Constants {
    let buttonWidthRatio: CGFloat = 0.8
    let buttonHeight: CGFloat = 44.0
    let buttonBottomOffset: CGFloat = -24
    let infoContainerBottomOffset: CGFloat = -92
    let imageContainerWidthRatio: CGFloat = 0.8
}
private let constants = Constants()

class BeerDetailsViewController: UIViewController {
    
    var viewModel: BeerDetailsViewModelType?
    var style: BeerDetailsStyleType?
    
    private let scrollView = UIScrollView()
    private let imageContainer = UIView()
    private let imageView = UIImageView()
    private let infoBackView = UIView()
    private var infoContainer: BeerDetailsInfoView?
    private let toFavoritesButton = UIButton()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponents()
        applyStyle()
        bindViewModel()
    }
}

private extension BeerDetailsViewController {
    func configureViewComponents() {
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageContainer)
        
        infoBackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(infoBackView)
        
        let infoContainer: BeerDetailsInfoView = .loadFromNib()
        infoContainer.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(infoContainer)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageView)

        imageContainer.snp.makeConstraints {
            $0.top.equalTo(scrollView)
            $0.leading.trailing.equalTo(view)
            $0.height.equalTo(imageContainer.snp.width)
                .multipliedBy(constants.imageContainerWidthRatio)
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints {
            $0.leading.trailing.equalTo(imageContainer)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).priority(.high)
            $0.height.greaterThanOrEqualTo(imageContainer.snp.height).priority(.required)
            $0.bottom.equalTo(imageContainer.snp.bottom)
        }
        
        infoContainer.snp.makeConstraints {
            $0.top.equalTo(imageContainer.snp.bottom)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(scrollView).offset(constants.infoContainerBottomOffset)
        }
        self.infoContainer = infoContainer
        
        infoBackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view)
            $0.top.equalTo(infoContainer)
            $0.bottom.equalTo(view)
        }
        
        toFavoritesButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toFavoritesButton)
        toFavoritesButton.snp.makeConstraints {
            $0.height.equalTo(constants.buttonHeight)
            $0.width.equalToSuperview().multipliedBy(constants.buttonWidthRatio)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(constants.buttonBottomOffset)
        }
    }
    
    func applyStyle() {
        guard let style = style else { return }
        
        view.backgroundColor = style.backgroundColor
        imageContainer.backgroundColor = style.imageContainerBackgroundColor
        infoBackView.backgroundColor = style.infoBackViewBackgroundColor
        infoContainer?.style = style.infoViewStyle
        toFavoritesButton.apply(style: style.toFavoritesButtonStyle)
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.imageURL
            .drive(onNext: { [weak self] url in
                let placeholder = UIImage(named: "beer_placeholder")
                self?.imageView.setImage(from: url, placeholder: placeholder)
            })
            .disposed(by: disposeBag)
        
        viewModel.navigationBarTitle
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.toFavoritesButtonTitle
            .drive(toFavoritesButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        infoContainer?.viewModel = viewModel.infoViewModel
        
        viewModel.bindViewEvents(
            toFavoritesTap: toFavoritesButton.rx.tap.asSignal())
    }
}
