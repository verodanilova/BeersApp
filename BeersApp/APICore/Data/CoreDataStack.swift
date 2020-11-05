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
        context.persistentStoreCoordinator = coordinator
        return context
    }()
    
    private(set) lazy var apiManagedObjectContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()

    private let coordinator: NSPersistentStoreCoordinator

    init(modelName: String) {
        let model = Self.loadManagedObjectModel(with: modelName)
        self.coordinator = Self.loadPersistentStoreCoordinator(
            model: model, modelName: modelName)
    }

    /* Configuration constants */
    private static let storeMigrationOptions = [
        NSMigratePersistentStoresAutomaticallyOption: true,
        NSInferMappingModelAutomaticallyOption: true]
    private static let storeType = NSSQLiteStoreType
}

private extension CoreDataStack {
    static func loadManagedObjectModel(with modelName: String) -> NSManagedObjectModel {
        guard let modelURL = Bundle.main.url(
            forResource: modelName, withExtension: "momd") else {
            fatalError("Unable to find data model url")
        }

        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to load managed object model")
        }

        return model
    }
    
    static func loadPersistentStoreCoordinator(model: NSManagedObjectModel,
        modelName: String) -> NSPersistentStoreCoordinator {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        let fileManager = FileManager.default
        let storeName = "\(modelName).sqlite"
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let storeURL = documentsDirectoryURL?.appendingPathComponent(storeName)

        do {
            try coordinator.addPersistentStore(ofType: storeType,
                configurationName: nil, at: storeURL, options: storeMigrationOptions)
        } catch {
            print("Unable to add persistent store for model `\(modelName)'.  "
                + "Error: \(error.localizedDescription).")
            /* Remove the store and try again. */
            removeUnusableStore(of: coordinator, at: storeURL, ofType: storeType)
            
            do {
                try coordinator.addPersistentStore(ofType: storeType,
                    configurationName: nil, at: storeURL, options: storeMigrationOptions)
            } catch {
                fatalError("Unable to load persistent store")
            }
        }

        return coordinator
    }
    
    static func removeUnusableStore(of coordinator: NSPersistentStoreCoordinator,
        at url: URL?, ofType storeType: String) {
        guard let url = url else { return }
        
        print("Attempting to remove an unusable store (\(url)).")
        do {
            try coordinator.destroyPersistentStore(at: url, ofType: storeType, options: [:])
        } catch {
            print("Failed to remove the store (\(url)).")
        }
    }
}
