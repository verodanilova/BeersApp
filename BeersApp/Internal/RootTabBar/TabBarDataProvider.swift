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
        let listImage = UIImage(named: "beer_ic")
        let listTitle = NSLocalizedString(
            "Tab bar.List item.Title", comment: "Tab bar list item title")
        let listItem = TabBarItem(kind: .list, title: listTitle, image: listImage, tag: 0)
        
        let favoritesImage = UIImage(named: "favorites_ic")
        let favoritesTitle = NSLocalizedString(
            "Tab bar.Favorites item.Title", comment: "Tab bar favorites item title")
        let favoritesItem = TabBarItem(kind: .favorites,
            title: favoritesTitle, image: favoritesImage, tag: 1)
        
        return [listItem, favoritesItem]
    }
}

struct TabBarItem {
    var kind: TabBarItemKind
    var title: String
    var image: UIImage?
    var tag: Int
}
