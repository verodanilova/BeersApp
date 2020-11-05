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
