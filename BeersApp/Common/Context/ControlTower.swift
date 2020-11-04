//
//  ControlTower.swift
//  BeersApp
//
//  Created by Veronica Danilova on 31.10.2020.
//

import Foundation


final class ControlTower {
    private(set) var context: CommonContext
    
    init(rootController: RootControllerType) {
        /* Load a context provider. */
        let contextProvider = CommonContextProvider()
        
        /* Create a navigator. */
        let navigator = AppNavigator(contextProvider: contextProvider)
        
        /* API */
        let apiClient = APIClient(baseURL: appConfiguration.apiBaseURL)
        
        /* Create the context object. */
        self.context = ControlTowerCommonContext(
            navigator: navigator,
            beersAPI: apiClient)
        
        /* Update the context provider with the fresh context. */
        contextProvider.context = self.context
        
        /* Set navigation containers */
        navigator.setContainers()
        
        /* Set root controller items */
        let tabBarDataProvider = TabBarDataProvider(rootControllers: navigator.rootControllers)
        rootController.configureItems(with: tabBarDataProvider)
    }
    
}
