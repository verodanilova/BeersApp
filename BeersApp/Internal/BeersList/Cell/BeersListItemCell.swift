//
//  BeersListItemCell.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import UIKit

class BeersListItemCell: UITableViewCell {
    
    @IBOutlet private var beerImageView: UIImageView!
    @IBOutlet private var beerNameLabel: UILabel!
    @IBOutlet private var beerTaglineLabel: UILabel!
    @IBOutlet private var favoritesImageView: UIImageView!
    
    static var reuseId: String {
        return String(describing: self)
    }
    
    static var nibName: String {
        return String(describing: self)
    }
    
    var viewModel: BeersListItemViewModelType? {
        didSet {
            bindViewModel()
        }
    }
   
    /* Style should be set first */
    var style: BeersListItemStyleType? {
        didSet {
            applyStyle()
        }
    }
}

private extension BeersListItemCell {
    func applyStyle() {
        guard let style = style else { return }
        
        selectionStyle = .none
        beerNameLabel.apply(style: style.beerNameTextStyle)
        beerTaglineLabel.apply(style: style.beerTaglineTextStyle)
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel, let style = style else { return }
        
        let placeholder = UIImage(named: "beer_placeholder")
        beerImageView.setImage(from: viewModel.imageURL, placeholder: placeholder)
        
        beerNameLabel.text = viewModel.name
        beerTaglineLabel.text = viewModel.tagline
        
        if viewModel.isFavoriteBeer {
            favoritesImageView.image = style.highlightedStarImage
        } else {
            favoritesImageView.image = style.starImage
        }
    }
}
