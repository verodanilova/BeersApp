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
    case missingManagedObjectContext
    case serializingError(Error)
    case insertError(Error)
}

/** This protocol defines requirements for instances, which can be inserted into a managed
  object context from JSON representation. */
public protocol InsertableFromJSON {
    static func insertObject(fromJSON JSON: Any,
        to context: NSManagedObjectContext) throws -> Self
}

extension Array: InsertableFromJSON where Element: InsertableFromJSON {
    public static func insertObject(fromJSON JSON: Any,
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

extension InsertableFromJSON where Self: NSManagedObject & Decodable {
    public static func insertObject(fromJSON JSON: Any,
        to context: NSManagedObjectContext) throws -> Self {
        
        guard let input = JSON as? [String: Any],
            let data = try? JSONSerialization.data(withJSONObject: input) else {
            throw InsertableFromJSONError.invalidJSON
        }
        
        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = context
        
        return try decoder.decode(Self.self, from: data)
    }
}

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}
