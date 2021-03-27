//
//  FavoritesCollectionViewCell.swift
//  BeersApp
//
//  Created by Veronica Danilova on 27.03.2021.
//

import UIKit
import BeersCore

class FavoritesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var tileView: UIView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var alcoholValueLabel: UILabel!
    @IBOutlet private var alcoholLabel: UILabel!
    @IBOutlet private var bitternessValueLabel: UILabel!
    @IBOutlet private var bitternessLabel: UILabel!
    
    var style: FavoritesCellStyleType? {
        didSet { applyStyle() }
    }

    override var isHighlighted: Bool {
        didSet { applyHighlighting() }
    }
    
    static var reuseId: String {
        String(describing: self)
    }
    
    static var nibName: String {
        String(describing: self)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        tileView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }

    func configure(with beer: BeerListItem) {
        imageView.setImage(from: beer.imageURL)
        nameLabel.text = beer.name

        let configurator = FavoritesConfigurator()
        alcoholValueLabel.text = configurator.makeAlcoholUnit(from: beer)
        bitternessValueLabel.text = configurator.makeBitternessUnit(from: beer)
        
        applyTileGradient(.color(for: beer.colorKind))
    }
}

private extension FavoritesCollectionViewCell {
    func applyStyle() {
        guard let style = style else { return }
        
        tileView.backgroundColor = style.tileBackgroundColor
        tileView.clipsToBounds = true
        tileView.layer.cornerCurve = .continuous
        tileView.layer.cornerRadius = style.tileCornerRadius
        nameLabel.apply(style: style.nameLabelStyle)
        alcoholValueLabel.apply(style: style.sectionValueLabelStyle)
        alcoholLabel.apply(style: style.sectionLabelStyle)
        bitternessValueLabel.apply(style: style.sectionValueLabelStyle)
        bitternessLabel.apply(style: style.sectionLabelStyle)
        
        alcoholLabel.text = NSLocalizedString(
            "Favorites.Beer Info.Figures.Alcohol.Title",
            comment: "Beer info: Alcohol figure title")
        bitternessLabel.text = NSLocalizedString(
            "Favorites.Beer Info.Figures.Bitterness.Title",
            comment: "Beer info: Bitterness figure title")
    }
    
    func applyHighlighting() {
        UIView.animate(withDuration: 0.15) {
            self.transform = self.isHighlighted ? .init(scaleX: 0.96, y: 0.96) : .identity
        }
    }
    
    func applyTileGradient(_ tileColor: UIColor?) {
        let gradientColor = tileColor ?? .grainBrown
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            gradientColor.withAlphaComponent(0.6).cgColor,
            gradientColor.withAlphaComponent(0.75).cgColor,
            gradientColor.withAlphaComponent(0.85).cgColor,
            gradientColor.cgColor
        ]
        gradientLayer.locations = [0.0, 0.3, 0.5, 1.0]
        tileView.layer.addSublayer(gradientLayer)
    }
}
