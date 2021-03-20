//
//  BeersDataSource.swift
//  BeersApp
//
//  Created by Veronica Danilova on 07.11.2020.
//

import Foundation
import CoreData


public final class BeersDataSource: BeersDataSourceType {

    private let managedObjectContext: NSManagedObjectContext

    public init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    public func makeBaseBeersFRC() -> MultiFetchedResultsControllerDelegate<BeerInfo> {
        let request: NSFetchRequest<BeerInfo> = BeerInfo.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(
            keyPath: \BeerInfo.id, ascending: true)]
        return MultiFetchedResultsControllerDelegate(
            managedObjectContext: managedObjectContext, request: request)
    }
    
    public func makeBeerInfoFRC(withID id: Int) -> FetchedResultsControllerDelegate<BeerInfo> {
        let request: NSFetchRequest<BeerInfo> = BeerInfo.fetchRequest(id: id)
        return FetchedResultsControllerDelegate(
            managedObjectContext: managedObjectContext, request: request)
    }
    
    public func makeBeersFRC(withIDs ids: Set<Int>) -> MultiFetchedResultsControllerDelegate<BeerInfo> {
        let request: NSFetchRequest<BeerInfo> = BeerInfo.fetchRequest(ids: ids)
        return MultiFetchedResultsControllerDelegate(
            managedObjectContext: managedObjectContext, request: request)
    }
    
    public func makeFilteredBeersFRC(storage: BeerFiltersStorageType)
        -> MultiFetchedResultsControllerDelegate<BeerInfo> {
        let request: NSFetchRequest<BeerInfo> = BeerInfo.fetchRequest(withFilters: storage)
        return MultiFetchedResultsControllerDelegate(
            managedObjectContext: managedObjectContext, request: request)
    }
}
