//
//  PersistentStack.swift
//  BeersCore
//
//  Created by Veronica Danilova on 20.03.2021.
//

import CoreData

public protocol PersistentStack {
    /** A background managed object context */
    var managedObjectContext: NSManagedObjectContext {get}
}
