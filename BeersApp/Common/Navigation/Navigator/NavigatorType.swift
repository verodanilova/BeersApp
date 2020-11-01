//
//  NavigatorType.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import Foundation


enum NavigationTarget {
    case beerDetails
}

protocol NavigatorType {
    func navigate(to target: NavigationTarget, in containerKind: AppNavigationContainerKind)
}

extension AppNavigator: NavigatorType {
    func navigate(to target: NavigationTarget, in containerKind: AppNavigationContainerKind) {
        switch target {
            case .beerDetails:
                navigateToBeerDetails(containerKind)
        }
    }
}

private extension AppNavigator {
    func navigateToBeerDetails(_ containerKind: AppNavigationContainerKind) {
        let controller = screensFactory.makeBeerDetails().controller
        let container = containerForKind(containerKind)
        container.push(controller)
    }
}
