//
//  InsertableFromJSON.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import CoreData


enum InsertableFromJSONError: Error {
    case invalidJSON
    case serializingError(Error)
    case insertError(Error)
}

/** This protocol defines requirements for instances, which can be inserted into a managed
  object context from JSON representation. */
protocol InsertableFromJSON {
    static func insertObject(fromJSON JSON: Any) throws -> Self
}
