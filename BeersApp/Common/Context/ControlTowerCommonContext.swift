//
//  ControlTowerCommonContext.swift
//  BeersApp
//
//  Created by Veronica Danilova on 31.10.2020.
//

import Foundation
import CoreData


protocol CommonContext: NavigatorContext,
    BeersAPIContext,
    DataContext,
    FavoriteBeersStorageContext {
}

struct ControlTowerCommonContext {
    let navigator: NavigatorType
    let beersAPI: BeersAPI
    let persistentStack: PersistentStack
    let favoriteBeersStorage: FavoriteBeersStorageType
}

extension ControlTowerCommonContext: CommonContext {
}

extension ControlTowerCommonContext: DataContext {
    var managedObjectContext: NSManagedObjectContext {
        return persistentStack.managedObjectContext
    }
}
