//
//  RootTabBarController.swift
//  BeersApp
//
//  Created by Veronica Danilova on 31.10.2020.
//

import UIKit


protocol RootControllerType {
    func configureItems(with provider: TabBarDataProviderType)
}

class RootTabBarController: UITabBarController {
}

extension RootTabBarController: RootControllerType {
    func configureItems(with provider: TabBarDataProviderType) {
        var viewControllers: [UIViewController] = []
        let items = provider.items
        
        provider.rootControllers.forEach { rootController in
            guard let item = items.filter({ $0.kind == rootController.kind }).first else {
                return
            }

            let controller = rootController.controller
            let tabBarItem = UITabBarItem(title: item.title, image: item.image, tag: item.tag)
            controller.tabBarItem = tabBarItem
            viewControllers.append(controller)
        }
        
        self.setViewControllers(viewControllers, animated: false)
    }
}

