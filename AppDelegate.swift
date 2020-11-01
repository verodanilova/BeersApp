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
    var controlTower: ControlTower!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let rootController = RootTabBarController()
        
        self.controlTower = ControlTower(rootController: rootController)
        
        window = UIWindow()
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
        
        return true
    }

}

