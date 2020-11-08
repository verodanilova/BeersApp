//
//  Contexts.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import Foundation
import CoreData


protocol NavigatorContext {
    var navigator: NavigatorType {get}
}

protocol DataContext {
    var managedObjectContext: NSManagedObjectContext {get}
}

protocol BeersAPIContext {
    var beersAPI: BeersAPI {get}
}

protocol FavoriteBeersStorageContext {
    var favoriteBeersStorage: FavoriteBeersStorageType {get}
}

protocol BeersDataSourceContext {
    var beersDataSource: BeersDataSourceType {get}
}
