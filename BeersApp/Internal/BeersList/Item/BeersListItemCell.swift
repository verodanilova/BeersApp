//
//  BeersListItemCell.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import UIKit
import RxSwift
import RxCocoa

private struct Constants {
    static let shadowLayerName = "shadowLayer"
    static let tileCornerRadius: CGFloat = 24
    static let imageBorderWidth: CGFloat = 2
}

class BeersListItemCell: UITableViewCell {
    
    @IBOutlet private var imageContainerView: UIView!
    @IBOutlet private var beerImageView: UIImageView!
    @IBOutlet private var tileView: UIView!
    @IBOutlet private var beerNameLabel: UILabel!
    @IBOutlet private var alcoholLabel: UILabel!
    @IBOutlet private var alcoholValueLabel: UILabel!
    @IBOutlet private var bitternessLabel: UILabel!
    @IBOutlet private var bitternessValueLabel: UILabel!
    @IBOutlet private var toFavoritesButton: UIButton!
    
    static var reuseId: String {
        String(describing: self)
    }
    
    static var nibName: String {
        String(describing: self)
    }

    /* Style should be set first */
    var style: BeersListItemStyleType? {
        didSet { applyStyle() }
    }
    
    var toFavoritesAction: (() -> ())?
    
    private var beerColor: UIColor?
    private var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dropShadow()
    }
    
    func configure(with beer: BeerListItem) {
        updateUI(with: beer)
        
        toFavoritesButton.rx.tap.asDriver()
            .drive(onNext: toFavoritesButtonTap)
            .disposed(by: disposeBag)
    }
}

private extension BeersListItemCell {
    func applyStyle() {
        guard let style = style else { return }
        
        selectionStyle = .none
        beerNameLabel.apply(style: style.beerNameTextStyle)
        alcoholLabel.apply(style: style.figureLabelStyle)
        alcoholValueLabel.apply(style: style.figureValueStyle)
        bitternessLabel.apply(style: style.figureLabelStyle)
        bitternessValueLabel.apply(style: style.figureValueStyle)
        
        tileView.backgroundColor = .clear
        imageContainerView.backgroundColor = .clear
        toFavoritesButton.apply(style: style.toFavoritesButtonStyle)
        
        alcoholLabel.text = NSLocalizedString(
            "Beer list.Item.Alcohol.Title",
            comment: "Beer list item: alcohol title")
        bitternessLabel.text = NSLocalizedString(
            "Beer list.Item.Bitterness.Title",
            comment: "Beer list item: bitterness title")
    }
    
    func updateUI(with beer: BeerListItem) {
        let placeholder = UIImage(named: "beer_placeholder")
        beerImageView.setImage(from: beer.imageURL, placeholder: placeholder)
        
        beerNameLabel.text = beer.name
        beerColor = .color(for: beer.colorKind)
        
        let configurator = BeerListConfigurator()
        alcoholValueLabel.text = configurator.makeAlcoholUnit(from: beer)
        bitternessValueLabel.text = configurator.makeBitternessUnit(from: beer)
        
        let buttonIcon = beer.isFavorite ? style?.isFavoriteImage : style?.isNotFavoriteImage
        toFavoritesButton.setImage(buttonIcon, for: .normal)
    }
}

// MARK: - Actions
private extension BeersListItemCell {
    func toFavoritesButtonTap() {
        toFavoritesAction?()
    }
}

// MARK: - Shadow configuration
private extension BeersListItemCell {
    func dropShadow() {
        contentView.layoutIfNeeded()
        clearShadows()
        dropTileViewShadow()
        dropImageViewShadow()
        dropButtonShadow()
    }
    
    func clearShadows() {
        let shadowViews = [tileView, imageContainerView, toFavoritesButton]
        shadowViews.forEach { view in
            view?.layer.sublayers?
                .filter { $0.name == Constants.shadowLayerName }
                .forEach { $0.removeFromSuperlayer() }
        }
    }
    
    func dropTileViewShadow() {
        tileView.layoutIfNeeded()
        
        let path = makeTileShadowPath()
        let shadowLayer = makeShadowLayer(with: path, fillColor: .spanishWhite)
        tileView.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func dropImageViewShadow() {
        let path = makeRoundedPath(for: imageContainerView)
        let shadowLayer = makeShadowLayer(with: path, fillColor: .white)
        let strokeColor = beerColor ?? .grainBrown
        shadowLayer.strokeColor = strokeColor.cgColor
        shadowLayer.lineWidth = Constants.imageBorderWidth
        imageContainerView.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func dropButtonShadow() {
        let path = makeRoundedPath(for: toFavoritesButton)
        let shadowLayer = makeShadowLayer(with: path, fillColor: .white)
        toFavoritesButton.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func makeShadowLayer(with path: CGPath, fillColor: UIColor) -> CAShapeLayer {
        let shadowLayer = CAShapeLayer()
        shadowLayer.name = Constants.shadowLayerName
        shadowLayer.path = path
        shadowLayer.fillColor = fillColor.cgColor
        shadowLayer.shadowPath = path
        
        if let style = style {
            shadowLayer.addShadow(style.viewShadow)
        }
        
        return shadowLayer
    }
    
    func makeTileShadowPath() -> CGPath {
        let cornerRadius = Constants.tileCornerRadius
        let width = tileView.bounds.width
        let height = tileView.bounds.height
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: cornerRadius, y: 0))
        path.addLine(to: CGPoint(x: width - cornerRadius, y: 0))
        path.addArc(withCenter: CGPoint(x: width - cornerRadius, y: cornerRadius),
                    radius: cornerRadius,
                    startAngle: CGFloat(270).toRadians(),
                    endAngle: CGFloat(0).toRadians(),
                    clockwise: true)
        path.addLine(to: CGPoint(x: width, y: height / 2 - cornerRadius))
        path.addArc(withCenter: CGPoint(x: width, y: height / 2),
                    radius: cornerRadius,
                    startAngle: CGFloat(270).toRadians(),
                    endAngle: CGFloat(90).toRadians(),
                    clockwise: false)
        path.addLine(to: CGPoint(x: width, y: height - cornerRadius))
        path.addArc(withCenter: CGPoint(x: width - cornerRadius, y: height - cornerRadius),
                    radius: cornerRadius,
                    startAngle: CGFloat(0).toRadians(),
                    endAngle: CGFloat(90).toRadians(),
                    clockwise: true)
        path.addLine(to: CGPoint(x: 0, y: height))
        path.close()
        
        return path.cgPath
    }
    
    func makeRoundedPath(for view: UIView) -> CGPath {
        let bounds = view.bounds
        let radius = view.frame.height / 2
        return UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
    }
}
