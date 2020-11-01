//
//  AppNavigator.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import Foundation


final class AppNavigator {
    private let contextProvider: ContextProvider
    let screensFactory = ScreensFactory()
    
    var containers: [AppNavigationContainerKind: NavigationContainerType] = [:]
    var rootControllers: [RootControllerPack] = []
    
    init(contextProvider: ContextProvider) {
        self.contextProvider = contextProvider
        
        setContainers()
    }
    
    func setContainers() {
        let listContainer = makeListContainer()
        containers[.list] = listContainer
        rootControllers.append((kind: .list, controller: listContainer.navigationController))
        
        let favoritesContainer = makeFavoritesContainer()
        containers[.favorites] = favoritesContainer
        rootControllers.append((kind: .favorites, controller: favoritesContainer.navigationController))
    }
}

// MARK: - Access to the context
extension AppNavigator {
    var context: CommonContext {
        guard let context: CommonContext = contextProvider.provideContext() else {
            fatalError("The context provider must supply a valid context")
        }

        return context
    }
}

// MARK: - Container providing
extension AppNavigator {
    func containerForKind(_ kind: AppNavigationContainerKind) -> NavigationContainerType {
        guard let container = containers[kind] else {
            fatalError("Missing container for kind <\(kind)>")
        }
        return container
    }
}

// MARK: - Navigation container preparation
private extension AppNavigator {
    func makeListContainer() -> NavigationContainer {
        let root = screensFactory.makeBeersList()
        return NavigationContainer(rootController: root.controller)
    }
    
    func makeFavoritesContainer() -> NavigationContainer {
        let root = screensFactory.makeFavoriteBeers()
        return NavigationContainer(rootController: root.controller)
    }
}
