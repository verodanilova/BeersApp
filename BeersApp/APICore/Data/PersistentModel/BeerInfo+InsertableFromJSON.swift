//
//  BeersInfo+InsertableFromJSON.swift
//  BeersApp
//
//  Created by Veronica Danilova on 05.11.2020.
//

import CoreData


extension BeerInfo: InsertableFromJSON {
    static func insertObject(fromJSON JSON: Any,
        to context: NSManagedObjectContext) throws -> Self {
        
        guard let input = JSON as? [String: Any] else {
            throw InsertableFromJSONError.invalidJSON
        }
        
        let object = context.insertNew() as Self
        object.id = input[Keys.id.rawValue] as? Int16 ?? 0
        object.name = input[Keys.name.rawValue] as? String
        object.tagline = input[Keys.tagline.rawValue] as? String
        object.beerDescription = input[Keys.description.rawValue] as? String
        let imageURLString = input[Keys.imageURL.rawValue] as? String ?? ""
        object.imageURL = URL(string: imageURLString)
        object.alcoholIndex = input[Keys.alcohol.rawValue] as? Double ?? 0.0
        object.bitternessIndex = input[Keys.bitterness.rawValue] as? Double ?? 0.0
        object.colorIndex = input[Keys.color.rawValue] as? Double ?? 0.0

        return object
    }
}

private typealias Keys = BeerInfoKeys
private enum BeerInfoKeys: String {
    case id = "id"
    case name = "name"
    case tagline = "tagline"
    case description = "description"
    case imageURL = "image_url"
    case alcohol = "abv"
    case bitterness = "ibu"
    case color = "ebc"
}
