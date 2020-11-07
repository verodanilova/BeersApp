//
//  FetchedResultsControllerDelegate.swift
//  BeersApp
//
//  Created by Veronica Danilova on 05.11.2020.
//

import Foundation
import CoreData
import RxSwift
import RxCocoa


protocol FetchedResultsControllerDelegateType {
    associatedtype Item: NSFetchRequestResult
    var currentItem: Item? {get}
    var fetchedItem: Driver<Item> {get}
}

final class FetchedResultsControllerDelegate<Item: NSFetchRequestResult>: NSObject,
    NSFetchedResultsControllerDelegate, Disposable,
    FetchedResultsControllerDelegateType {
    typealias Context = DataContext

    var currentItem: Item?
    let fetchedItem: Driver<Item>

    private let request: NSFetchRequest<Item>

    private let context: Context
    private let fetchedResultsController: NSFetchedResultsController<Item>
    private let itemSubject = ReplaySubject<Item>.create(bufferSize: 1)

    public init(context: Context, request: NSFetchRequest<Item>) {
        self.context = context
        self.request = request
        request.fetchLimit = 1

        self.fetchedItem = itemSubject.asDriver { _ in
                fatalError("Unexpected error occurred while converting itemSubject to Driver")
            }
        
        fetchedResultsController = NSFetchedResultsController<Item>(
            fetchRequest: request, managedObjectContext: context.managedObjectContext,
            sectionNameKeyPath: nil, cacheName: nil)

        super.init()

        fetchedResultsController.delegate = self
        performFetch()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        try? controller.performFetch()
        if let fetchedObject = controller.fetchedObjects?.first as? Item {
            currentItem = fetchedObject
            sendFetchedObject(fetchedObject)
        } else {
            currentItem = nil
        }
    }
    
    func dispose() {
        itemSubject.dispose()
    }
}

private extension FetchedResultsControllerDelegate {
    func performFetch() {
        do {
            try fetchedResultsController.performFetch()
            if let fetchedObject = fetchedResultsController.fetchedObjects?.first {
                currentItem = fetchedObject
                sendFetchedObject(fetchedObject)
            }
        } catch {
            print("Fetched results controller delegate failed to fetch changes. Error: \(error)")
        }
    }

    func sendFetchedObject(_ object: Item) {
        itemSubject.onNext(object)
    }
}
