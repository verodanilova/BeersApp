//
//  BeersListItemCell.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import UIKit

class BeersListItemCell: UITableViewCell {
    
    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var beerNameLabel: UILabel!
    @IBOutlet var beerTaglineLabel: UILabel!
    
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
   
    var style: BeersListItemStyleType? {
        didSet {
            bindViewModel()
        }
    }
}

private extension BeersListItemCell {
    func applyStyle() {
        guard let style = style else { return }
        
        beerNameLabel.apply(style: style.beerNameTextStyle)
        beerTaglineLabel.apply(style: style.beerTaglineTextStyle)
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        let placeholder = UIImage(named: "beer_placeholder")
        beerImageView.setImage(from: viewModel.imageURL, placeholder: placeholder)
        
        beerNameLabel.text = viewModel.name
        beerTaglineLabel.text = viewModel.tagline
    }
}
