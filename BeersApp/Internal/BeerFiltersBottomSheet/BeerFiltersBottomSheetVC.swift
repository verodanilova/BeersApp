//
//  BeerFiltersBottomSheetViewController.swift
//  BeersApp
//
//  Created by Veronica Danilova on 08.11.2020.
//

import UIKit


class BeerFiltersBottomSheetViewController: BaseBottomSheetViewController {
    var viewModel: BeerFiltersBottomSheetViewModelType?
    var style: BeerFiltersBottomSheetStyleType?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        addFiltersView()
    }
    
    private func addFiltersView() {
        let filtersView: FiltersBottomSheetView = .loadFromNib()
        filtersView.delegate = self
        filtersView.style = style
        filtersView.viewModel = viewModel
        setContentView(filtersView)
    }
}

