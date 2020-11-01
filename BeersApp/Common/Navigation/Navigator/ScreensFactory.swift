//
//  ScreensFactory.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import Foundation


final class ScreensFactory {
    typealias Pack<Controller, Model> = (controller: Controller, model: Model)
    
    func pack<Controller, Model>(_ controller: Controller, _ model: Model) -> Pack<Controller, Model> {
        return (controller: controller, model: model)
    }
}

extension ScreensFactory {
    func makeBeersList() -> Pack<BeersListViewController, BeersListViewModelType> {
        let viewModel = BeersListViewModel()
        let controller = BeersListViewController()
        controller.viewModel = viewModel
        return pack(controller, viewModel)
    }
    
    func makeFavoriteBeers() -> Pack<FavoriteBeersViewController, FavoriteBeersViewModelType> {
        let viewModel = FavoriteBeersViewModel()
        let controller = FavoriteBeersViewController()
        controller.viewModel = viewModel
        return pack(controller, viewModel)
    }
    
    func makeBeerDetails() -> Pack<BeerDetailsViewController, BeerDetailsViewModelType> {
        let viewModel = BeerDetailsViewModel()
        let controller = BeerDetailsViewController()
        controller.viewModel = viewModel
        return pack(controller, viewModel)
    }
}
