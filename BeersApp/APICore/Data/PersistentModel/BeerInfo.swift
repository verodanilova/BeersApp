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
    
    class func fetchRequest(withFilters storage: BeerFiltersStorageType) -> NSFetchRequest<BeerInfo> {
        let request: NSFetchRequest<BeerInfo> = fetchRequest()
        
        var predicates: [NSPredicate] = []
        if let alcoholLowerValue = storage.alcoholLowerValue {
            let value = Double(round(10 * alcoholLowerValue)/10)
            let predicate = NSPredicate(format: "alcoholIndex > %lf", value)
            predicates.append(predicate)
        }
        if let alcoholUpperValue = storage.alcoholUpperValue {
            let value = Double(round(10 * alcoholUpperValue)/10)
            let predicate = NSPredicate(format: "alcoholIndex < %lf", value)
            predicates.append(predicate)
        }
        if let bitternessLowerValue = storage.bitternessLowerValue {
            let value = Int(bitternessLowerValue)
            let predicate = NSPredicate(format: "bitternessIndex > %ld", value)
            predicates.append(predicate)
        }
        if let bitternessUpperValue = storage.bitternessUpperValue {
            let value = Int(bitternessUpperValue)
            let predicate = NSPredicate(format: "bitternessIndex < %ld", value)
            predicates.append(predicate)
        }
        if let colorLowerValue = storage.colorLowerValue {
            let value = Int(colorLowerValue)
            let predicate = NSPredicate(format: "colorIndex > %ld", value)
            predicates.append(predicate)
        }
        if let colorUpperValue = storage.colorUpperValue {
            let value = Int(colorUpperValue)
            let predicate = NSPredicate(format: "colorIndex < %ld", value)
            predicates.append(predicate)
        }
        
        if !predicates.isEmpty {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }
        
        request.sortDescriptors = [NSSortDescriptor(
            keyPath: \BeerInfo.id, ascending: true)]
        return request
    }
}
