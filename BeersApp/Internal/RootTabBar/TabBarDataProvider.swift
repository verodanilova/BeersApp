//
//  TabBarDataProvider.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import UIKit


typealias RootControllerPack = (kind: TabBarItemKind, controller: UIViewController)

enum TabBarItemKind {
    case list
    case favorites
}

protocol TabBarDataProviderType {
    var items: [TabBarItem] {get}
    var rootControllers: [RootControllerPack] {get}
}

struct TabBarDataProvider: TabBarDataProviderType {
    var items: [TabBarItem] = []
    var rootControllers: [RootControllerPack]
    
    init(rootControllers: [RootControllerPack]) {
        self.rootControllers = rootControllers
        self.items = configureItems()
    }
}

private extension TabBarDataProvider {
    func configureItems() -> [TabBarItem] {
        let listImage = UIImage(named: "list_ic")
        let listItem = TabBarItem(kind: .list, image: listImage, tag: 0)
        
        let favoritesImage = UIImage(named: "favorites_ic")
        let favoritesItem = TabBarItem(kind: .favorites, image: favoritesImage, tag: 1)
        
        return [listItem, favoritesItem]
    }
}

struct TabBarItem {
    var kind: TabBarItemKind
    var image: UIImage?
    var tag: Int
}
