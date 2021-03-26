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
    let imageInset: CGFloat = 16
    let screenWidth: CGFloat = UIScreen.main.bounds.width
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
    private let foodPairingView = BeerDetailsFoodPairingView()
    private let toFavoritesButton = UIButton()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewComponents()
        applyStyle()
        bindViewModel()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        applyImageGradient()
    }
}

private extension BeerDetailsViewController {
    func configureViewComponents() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        scrollView.addSubview(imageContainer)
        scrollView.addSubview(infoBackView)
        
        let infoContainer: BeerDetailsInfoView = .loadFromNib()
        scrollView.addSubview(infoContainer)
        scrollView.addSubview(imageView)

        imageContainer.snp.makeConstraints {
            $0.top.equalTo(scrollView).inset(-constants.imageInset)
            $0.leading.trailing.equalTo(view)
            $0.height.equalTo(imageContainer.snp.width)
                .multipliedBy(constants.imageContainerWidthRatio)
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints {
            $0.leading.trailing.equalTo(imageContainer)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).priority(.high)
            $0.height.greaterThanOrEqualTo(imageContainer.snp.height).priority(.required)
            $0.bottom.equalTo(imageContainer.snp.bottom)
        }
        
        infoContainer.snp.makeConstraints {
            $0.top.equalTo(imageContainer.snp.bottom).offset(constants.imageInset)
            $0.leading.trailing.equalTo(view)
        }
        self.infoContainer = infoContainer
        
        infoBackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view)
            $0.top.equalTo(infoContainer)
            $0.bottom.equalTo(view)
        }
        
        scrollView.addSubview(foodPairingView)
        foodPairingView.snp.makeConstraints {
            $0.top.equalTo(infoContainer.snp.bottom)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(scrollView.snp.bottom)
        }

//        view.addSubview(toFavoritesButton)
//        toFavoritesButton.snp.makeConstraints {
//            $0.height.equalTo(constants.buttonHeight)
//            $0.width.equalToSuperview().multipliedBy(constants.buttonWidthRatio)
//            $0.centerX.equalToSuperview()
//            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(constants.buttonBottomOffset)
//        }
    }
    
    func applyStyle() {
        guard let style = style else { return }
        
        scrollView.backgroundColor = style.backgroundColor
        imageContainer.backgroundColor = style.imageContainerBackgroundColor
        infoBackView.backgroundColor = style.infoBackViewBackgroundColor
        infoContainer?.style = style.infoViewStyle
        foodPairingView.style = style.foodPairingStyle
        toFavoritesButton.apply(style: style.toFavoritesButtonStyle)
    }
    
    func applyImageGradient() {
        let albescentWhite = UIColor.albescentWhite.cgColor
        let grainBrown = UIColor.grainBrown.withAlphaComponent(0.7).cgColor
        let roundedCornersGap = style?.infoViewStyle.topCornerRadius ?? 0
        var gradientFrame = imageContainer.bounds
        gradientFrame.size.height = imageContainer.bounds.height + roundedCornersGap

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientFrame
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.colors = [albescentWhite, grainBrown]
        imageContainer.layer.addSublayer(gradientLayer)
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.imageURL
            .drive(onNext: { [weak self] url in
                let placeholder = UIImage(named: "beer_placeholder")
                self?.imageView.setImage(from: url, placeholder: placeholder)
            })
            .disposed(by: disposeBag)
//
//        viewModel.navigationBarTitle
//            .drive(navigationItem.rx.title)
//            .disposed(by: disposeBag)
        
        viewModel.toFavoritesButtonTitle
            .drive(toFavoritesButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        viewModel.isInActivity
            .drive(onNext: changeShimmerState)
            .disposed(by: disposeBag)
        
        infoContainer?.viewModel = viewModel.infoViewModel
        foodPairingView.viewModel = viewModel.foodPairingViewModel
        
        viewModel.bindViewEvents(
            toFavoritesTap: toFavoritesButton.rx.tap.asSignal())
    }
    
    func changeShimmerState(_ isShimmering: Bool) {
        infoContainer?.isShimmering = isShimmering
        toFavoritesButton.isHidden = isShimmering
        
        if isShimmering {
            imageView.startShimmering()
        } else {
            imageView.stopShimmering()
        }
    }
}
