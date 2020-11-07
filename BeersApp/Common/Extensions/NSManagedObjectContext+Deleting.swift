//
//  NSManagedObjectContext+Deleting.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import Foundation
import CoreData


extension NSManagedObjectContext {
    func deleteAllObjects(associatedWith theClass: AnyClass) {
        let className = String(describing: theClass.self)

        guard let entityDescription = NSEntityDescription.entity(
            forEntityName: className, in: self) else {
            return
        }

        deleteAllObjectsForEntity(entityDescription)
        storeChanges()
    }

    private func deleteAllObjectsForEntity(_ entity: NSEntityDescription) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entity

        let fetchResults = try? fetch(fetchRequest)

        if let managedObjects = fetchResults as? [NSManagedObject] {
            for object in managedObjects {
                delete(object)
            }
        }
    }
}
