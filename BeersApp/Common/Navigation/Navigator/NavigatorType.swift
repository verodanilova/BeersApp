//
//  NavigatorType.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import Foundation


enum NavigationTarget {
    case beerDetails(id: Int)
    case beerFiltersBottomSheet(storage: BeerFiltersStorageType)
}

protocol NavigatorType {
    func navigate(to target: NavigationTarget, in containerKind: AppNavigationContainerKind)
}

extension AppNavigator: NavigatorType {
    func navigate(to target: NavigationTarget, in containerKind: AppNavigationContainerKind) {
        switch target {
            case let .beerDetails(id):
                navigateToBeerDetails(containerKind, itemId: id)
            case let .beerFiltersBottomSheet(storage):
                showFiltersBottomSheet(containerKind, storage: storage)
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
        storage: BeerFiltersStorageType) {
        let style = BeerFiltersBottomSheetStyle()
        let viewModel = BeerFiltersBottomSheetViewModel(storage: storage)
        let controller = BeerFiltersBottomSheetViewController()
        controller.style = style
        controller.viewModel = viewModel
        controller.configurePresentationStyle()
        let container = containerForKind(containerKind)
        container.present(controller)
    }
}
