//
//  WidgetManager.swift
//  BeerOfTheDayWidgetExtension
//
//  Created by Veronica Danilova on 21.03.2021.
//

import UIKit
import WidgetKit

class WidgetManager {
    
    struct Constants {
        static let widgetScheme = "widget://"
    }

    private let apiClient = WidgetAPIClient()

    func loadBeerEntries(completion: @escaping ([BeerEntry]) -> ()) {
        apiClient.loadBeers { beers in
            let currentDate = Date()
            let date = Calendar.current.date(byAdding: .day,
                value: 1, to: currentDate) ?? Date()
            let entry = BeerEntry(date: date, beers: beers)
            completion([entry])
        }
    }
    
    static func image(for beer: WidgetBeerInfo) -> UIImage? {
        guard let data = beer.imageData else {
            return UIImage(named: "defaultImage")
        }
        return UIImage(data: data)
    }
    
    static func widgetURL(for beer: WidgetBeerInfo?) -> URL? {
        guard let id = beer?.id else {
            return nil
        }
        
        let urlString = Constants.widgetScheme + "\(id)"
        return URL(string: urlString)
    }
        
    static let samples: [WidgetBeerInfo] = {
        var beer1 = WidgetBeerInfo(id: 1, name: "AB:15", description: "A salted caramel popcorn Imperial Ale. Bourbon and Rum barrel aged, this 12.8% ale has complex and twisting flavours. Bitter caramel, wood, smoke, spice, treacle and vanilla are all present and intertwine against a smooth and lightly chewy mouthfeel. The salted caramel popcorn lends subtle hints of a smoky brininess.")
        beer1.imageData = UIImage(named: "AB_15")?.pngData()
        
        var beer2 = WidgetBeerInfo(id: 2, name: "How To Disappear Completely", description: "Jam-packed with two of our favourite hops - Columbus and Centennial, it has 198 (yes one hundred and ninety eight) theoretical IBUs. We use a lot of caramalt, some amber malt and some chocolate malt to give the little beer as much body and mouthfeel as possible and the ability to handle all the hops we threw at it. We think this beer is the world’s first ever Imperial Mild. Imperial in terms of hop profile. An Imperially Hopped Mild. BrewDog’s Imperial Mild. How to Disappear Completely.")
        beer2.imageData = UIImage(named: "How_To_Disappear_Completely")?.pngData()
        
        var beer3 = WidgetBeerInfo(id: 3, name: "Morag's Mojito - B-Sides", description: "A cunning cocktail blend of grapefruit hops, ginger spice and refreshing mint.")
        beer3.imageData = UIImage(named: "Morag_s_mojito")?.pngData()

        return [beer1, beer2, beer3]
    }()
}

