//
//  NavigationContainer.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import UIKit


protocol NavigationContainerType {
    typealias Item = UIViewController
    func push(_ item: Item)
    func push(_ item: Item, animated: Bool)
    func present(_ item: Item)
}

final class NavigationContainer {
    let navigationController: UINavigationController

    init(rootController: UIViewController) {
        self.navigationController = UINavigationController(rootViewController: rootController)
    }
}

extension NavigationContainer: NavigationContainerType {
    func push(_ item: Item) {
        navigationController.pushViewController(item, animated: true)
    }
    
    func push(_ item: Item, animated: Bool) {
        navigationController.pushViewController(item, animated: animated)
    }
    func present(_ item: Item) {
        navigationController.present(item, animated: false, completion: nil)
    }
}
