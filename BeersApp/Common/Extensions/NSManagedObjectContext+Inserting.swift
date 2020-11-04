//
//  NSManagedObjectContext+Inserting.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import CoreData


extension NSManagedObjectContext {
    /** Save changes in context */
    func storeChanges() {
        if self.hasChanges {
            do {
                try self.save()
            } catch {
                print("Failed to save a managed object context with error: \(error)")
            }
        }
    }

    /** Insert new entity to context */
    func insertNew<O: NSManagedObject>() -> O {
        let entityName = String(describing: O.self)
        return NSEntityDescription.insertNewObject(forEntityName: entityName,
            into: self) as! O
    }
}

