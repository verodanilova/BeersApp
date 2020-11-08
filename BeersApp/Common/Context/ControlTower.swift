//
//  ControlTower.swift
//  BeersApp
//
//  Created by Veronica Danilova on 31.10.2020.
//

import Foundation
import CoreData


final class ControlTower {
    private(set) var context: CommonContext
    
    init(rootController: RootControllerType) {
        /* Load a context provider. */
        let contextProvider = CommonContextProvider()
        
        /* Create a navigator. */
        let navigator = AppNavigator(contextProvider: contextProvider)
        
        /* Persistent stack */
        let coreDataStack = CoreDataStack(modelName: appConfiguration.persistentStackModelName)
        
        /* API */
        let apiClient = APIClient(
            baseURL: appConfiguration.apiBaseURL,
            managedObjectContext: coreDataStack.managedObjectContext)
        
        /* Setting storage */
        let favoriteBeersStorage = FavoriteBeersStorage()
        
        /* Create the context object. */
        self.context = ControlTowerCommonContext(
            navigator: navigator,
            beersAPI: apiClient,
            persistentStack: coreDataStack,
            favoriteBeersStorage: favoriteBeersStorage)
        
        /* Update the context provider with the fresh context. */
        contextProvider.context = self.context
        
        /* Set navigation containers */
        navigator.setContainers()
        
        /* Set root controller items */
        let tabBarDataProvider = TabBarDataProvider(rootControllers: navigator.rootControllers)
        rootController.configureItems(with: tabBarDataProvider)
    }
    
}
