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
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Tab bar controller can be initialized only by code")
    }

    private func configureAppearance() {
        tabBar.tintColor = .freshEggplant
        
        let appearance = tabBar.standardAppearance
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
    }
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
            let tabBarItem = UITabBarItem(title: nil, image: item.image, tag: item.tag)
            tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            controller.tabBarItem = tabBarItem
            viewControllers.append(controller)
        }
        
        self.setViewControllers(viewControllers, animated: false)
    }
}

