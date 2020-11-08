//
//  BeerInfo.swift
//  BeersApp
//
//  Created by Veronica Danilova on 05.11.2020.
//

import Foundation
import CoreData


final class BeerInfo: NSManagedObject {

    @NSManaged var id: Int16
    @NSManaged var name: String?
    @NSManaged var tagline: String?
    @NSManaged var beerDescription: String?
    @NSManaged var imageURL: URL?
    
    @NSManaged var alcoholIndex: Double /* ABV */
    @NSManaged var bitternessIndex: Double /* IBU */
    @NSManaged var colorIndex: Double /* EBC */
}

extension BeerInfo {
    @nonobjc class func fetchRequest() -> NSFetchRequest<BeerInfo> {
        return NSFetchRequest(entityName: String(describing: BeerInfo.self))
    }
    
    class func fetchRequest(id: Int) -> NSFetchRequest<BeerInfo> {
        let request: NSFetchRequest<BeerInfo> = fetchRequest()
        request.predicate = NSPredicate(format: "id == %ld", id)
        request.sortDescriptors = [NSSortDescriptor(
            keyPath: \BeerInfo.id, ascending: true)]
        request.fetchLimit = 1
        return request
    }
    
    class func fetchRequest(ids: Set<Int>) -> NSFetchRequest<BeerInfo> {
        let request: NSFetchRequest<BeerInfo> = fetchRequest()
        request.predicate = NSPredicate(format: "id IN %@", ids)
        request.sortDescriptors = [NSSortDescriptor(
            keyPath: \BeerInfo.id, ascending: true)]
        return request
    }
}
