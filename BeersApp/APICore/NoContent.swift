//
//  NoContent.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import Foundation

// Temporary struct for API testing
struct NoContent {
    /* No content. */
    init() {
    }
}

extension NoContent: InsertableFromJSON {
    static func insertObject(fromJSON JSON: Any) throws -> NoContent {
        return NoContent()
    }
}
