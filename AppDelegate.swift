//
//  AppDelegate.swift
//  BeersApp
//
//  Created by Veronica Danilova on 31.10.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var controlTower: ControlTower?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let rootController = RootTabBarController()
        
        self.controlTower = ControlTower(rootController: rootController)
        
        window = UIWindow()
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme == "widget" {
            return handleWidgetUrl(url)
        }

       return false
    }
    
    private func handleWidgetUrl(_ url: URL) -> Bool {
        guard let controlTower = controlTower,
              let beerID = url.host,
              let id = Int(beerID)
        else {
            return false
        }
        
        let navigator = controlTower.context.navigator
        navigator.navigate(to: .beerDetails(id: id), in: .list)
        return true
    }
}

