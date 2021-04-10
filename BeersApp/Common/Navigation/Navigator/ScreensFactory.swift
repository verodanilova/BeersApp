//
//  ScreensFactory.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import Foundation


final class ScreensFactory {
    private let contextProvider: ContextProvider
    
    private var context: CommonContext {
        guard let context: CommonContext = contextProvider.provideContext() else {
            fatalError("The context provider must supply a valid context")
        }

        return context
    }
    
    init(contextProvider: ContextProvider) {
        self.contextProvider = contextProvider
    }
}

extension ScreensFactory {
    func makeBeersList() -> Pack<BeersListViewController, BeersListViewModelType> {
        let viewModel = BeersListViewModel(context: context)
        let style = BeersListStyle()
        let controller = BeersListViewController()
        controller.viewModel = viewModel
        controller.style = style
        return pack(controller, viewModel)
    }
    
    func makeFavoriteBeers() -> Pack<FavoritesViewController, FavoritesViewModelType> {
        let viewModel = FavoritesViewModel(context: context)
        let style = FavoritesStyle()
        let controller = FavoritesViewController(style: style, viewModel: viewModel)
        return pack(controller, viewModel)
    }
    
    func makeBeerDetails(for id: Int) -> Pack<BeerDetailsViewController, BeerDetailsViewModelType> {
        let viewModel = BeerDetailsViewModel(context: context, id: id)
        let style = BeerDetailsStyle()
        let controller = BeerDetailsViewController()
        controller.viewModel = viewModel
        controller.style = style
        return pack(controller, viewModel)
    }
}

extension ScreensFactory {
    typealias Pack<Controller, Model> = (controller: Controller, model: Model)
    
    func pack<Controller, Model>(_ controller: Controller, _ model: Model) -> Pack<Controller, Model> {
        return (controller: controller, model: model)
    }
}
