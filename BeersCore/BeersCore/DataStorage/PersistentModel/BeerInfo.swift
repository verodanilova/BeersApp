//
//  BeerInfo.swift
//  BeersApp
//
//  Created by Veronica Danilova on 05.11.2020.
//

import Foundation
import CoreData


public final class BeerInfo: NSManagedObject, Decodable {

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var tagline: String?
    @NSManaged public var beerDescription: String?
    @NSManaged public var imageURL: URL?
    @NSManaged public var foodPairings: [String]
    
    @NSManaged public var alcoholIndex: Double /* ABV */
    @NSManaged public var bitternessIndex: Double /* IBU */
    @NSManaged public var colorIndex: Double /* EBC */

    enum CodingKeys: String, CodingKey {
        case id, name, tagline, description
        case imageURL = "image_url"
        case alcohol = "abv"
        case bitterness = "ibu"
        case color = "ebc"
        case foodPairings = "food_pairing"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw InsertableFromJSONError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int16.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.tagline = try? container.decode(String.self, forKey: .tagline)
        self.beerDescription = try? container.decode(String.self, forKey: .description)
        let imageURLString = try? container.decode(String.self, forKey: .imageURL)
        self.imageURL = URL(string: imageURLString ?? "")
        self.alcoholIndex = (try? container.decode(Double.self, forKey: .alcohol)) ?? 0.0
        self.bitternessIndex = (try? container.decode(Double.self, forKey: .bitterness)) ?? 0.0
        self.colorIndex = (try? container.decode(Double.self, forKey: .color)) ?? 0.0
        self.foodPairings = (try? container.decode([String].self, forKey: .foodPairings)) ?? []
    }
}

extension BeerInfo: InsertableFromJSON { }

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
