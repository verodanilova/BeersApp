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
}

final class BeersDataSource: BeersDataSourceType {
    private let context: DataContext
    init(context: DataContext) {
        self.context = context
    }
    
    func makeBaseBeersFRC() -> MultiFetchedResultsControllerDelegate<BeerInfo> {
        let request: NSFetchRequest<BeerInfo> = BeerInfo.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(
            keyPath: \BeerInfo.id, ascending: true)]
        return MultiFetchedResultsControllerDelegate(context: context, request: request)
    }
    
    func makeBeerInfoFRC(withID id: Int) -> FetchedResultsControllerDelegate<BeerInfo> {
        let request:  NSFetchRequest<BeerInfo> = BeerInfo.fetchRequest(id: id)
        return FetchedResultsControllerDelegate(context: context, request: request)
    }
}
