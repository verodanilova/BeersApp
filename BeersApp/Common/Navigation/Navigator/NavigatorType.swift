//
//  NavigatorType.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import Foundation


enum NavigationTarget {
    case beerDetails(id: Int)
    case beerFiltersBottomSheet(model: BeerFiltersBottomSheetViewModelType)
}

protocol NavigatorType {
    func navigate(to target: NavigationTarget, in containerKind: AppNavigationContainerKind)
}

extension AppNavigator: NavigatorType {
    func navigate(to target: NavigationTarget, in containerKind: AppNavigationContainerKind) {
        switch target {
            case let .beerDetails(id):
                navigateToBeerDetails(containerKind, itemId: id)
            case let .beerFiltersBottomSheet(model):
                showFiltersBottomSheet(containerKind, model: model)
        }
    }
}

private extension AppNavigator {
    func navigateToBeerDetails(_ containerKind: AppNavigationContainerKind, itemId: Int) {
        let controller = screensFactory.makeBeerDetails(for: itemId).controller
        let container = containerForKind(containerKind)
        container.push(controller)
    }
    
    func showFiltersBottomSheet(_ containerKind: AppNavigationContainerKind,
        model: BeerFiltersBottomSheetViewModelType) {
        let style = BeerFiltersBottomSheetStyle()
        let controller = BeerFiltersBottomSheetViewController()
        controller.style = style
        controller.viewModel = model
        controller.configurePresentationStyle()
        let container = containerForKind(containerKind)
        container.present(controller)
    }
}
