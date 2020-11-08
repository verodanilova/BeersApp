//
//  BeersDataSource.swift
//  BeersApp
//
//  Created by Veronica Danilova on 07.11.2020.
//

import Foundation
import CoreData


protocol BeersDataSourceType {
    func makeBaseBeersFRC() -> MultiFetchedResultsControllerDelegate<BeerInfo>
    func makeBeerInfoFRC(withID id: Int) -> FetchedResultsControllerDelegate<BeerInfo>
    func makeBeersFRC(withIDs ids: Set<Int>) -> MultiFetchedResultsControllerDelegate<BeerInfo>
}

final class BeersDataSource: BeersDataSourceType {
    typealias Context = DataContext
    
    private let contextProvider: ContextProvider
    private var context: Context {
        guard let context: Context = contextProvider.provideContext() else {
            fatalError("The context provider must supply a valid context")
        }
        return context
    }
    
    init(contextProvider: ContextProvider) {
        self.contextProvider = contextProvider
    }
    
    func makeBaseBeersFRC() -> MultiFetchedResultsControllerDelegate<BeerInfo> {
        let request: NSFetchRequest<BeerInfo> = BeerInfo.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(
            keyPath: \BeerInfo.id, ascending: true)]
        return MultiFetchedResultsControllerDelegate(context: context, request: request)
    }
    
    func makeBeerInfoFRC(withID id: Int) -> FetchedResultsControllerDelegate<BeerInfo> {
        let request: NSFetchRequest<BeerInfo> = BeerInfo.fetchRequest(id: id)
        return FetchedResultsControllerDelegate(context: context, request: request)
    }
    
    func makeBeersFRC(withIDs ids: Set<Int>) -> MultiFetchedResultsControllerDelegate<BeerInfo> {
        let request: NSFetchRequest<BeerInfo> = BeerInfo.fetchRequest(ids: ids)
        return MultiFetchedResultsControllerDelegate(context: context, request: request)
    }
}
