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
}
