//
//  CoreDataStack.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import CoreData


protocol PersistentStack {
    /** Main queue managed object context */
    var managedObjectContext: NSManagedObjectContext {get}
    
    /** A background managed object context */
    var apiManagedObjectContext: NSManagedObjectContext {get}
}

final class CoreDataStack: PersistentStack {
  
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }()
    
    private(set) lazy var apiManagedObjectContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }()

    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(
            forResource: modelName, withExtension: "momd") else {
            fatalError("Unable to find data model url")
        }

        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to load managed object model")
        }

        return model
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let fileManager = FileManager.default
        let storeName = "\(modelName).sqlite"
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let persistentStoreURL = documentsDirectoryURL?.appendingPathComponent(storeName)

        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                configurationName: nil, at: persistentStoreURL, options: nil)
        } catch {
            fatalError("Unable to load persistent store")
        }

        return coordinator
    }()

    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
}
