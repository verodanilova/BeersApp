//
//  InsertableFromJSON.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import CoreData


let insertableFromJSONErrorDomain = "InsertableFromJSONErrorDomain"
enum InsertableFromJSONError: Error {
    case invalidJSON
    case serializingError(Error)
    case insertError(Error)
}

/** This protocol defines requirements for instances, which can be inserted into a managed
  object context from JSON representation. */
protocol InsertableFromJSON {
    static func insertObject(fromJSON JSON: Any,
        to context: NSManagedObjectContext) throws -> Self
}

extension Array: InsertableFromJSON where Element: InsertableFromJSON {
    static func insertObject(fromJSON JSON: Any,
        to context: NSManagedObjectContext) throws -> Array<Element> {
        guard let array = JSON as? [[String: Any]] else {
            let error = NSError(domain: insertableFromJSONErrorDomain, code: 0,
                userInfo: [NSLocalizedDescriptionKey: "Expected the JSON object of Array type"])
            throw error
        }

        return array.compactMap { elementJSON -> Element? in
            try? Element.insertObject(fromJSON: elementJSON, to: context)
        }
    }
}
