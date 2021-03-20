//
//  WidgetBeerInfo.swift
//  BeersApp
//
//  Created by Veronica Danilova on 20.03.2021.
//

import Foundation

struct WidgetBeerInfo: Hashable {
    let id: Int
    let name: String
    let description: String
    let imageURL: URL?
    
    static let samples = [
        WidgetBeerInfo(id: 1, name: "AB:15", description: "A salted caramel popcorn Imperial Ale. Bourbon and Rum barrel aged, this 12.8% ale has complex and twisting flavours. Bitter caramel, wood, smoke, spice, treacle and vanilla are all present and intertwine against a smooth and lightly chewy mouthfeel. The salted caramel popcorn lends subtle hints of a smoky brininess.", imageURL: nil),
        WidgetBeerInfo(id: 2, name: "How To Disappear Completely", description: "Jam-packed with two of our favourite hops - Columbus and Centennial, it has 198 (yes one hundred and ninety eight) theoretical IBUs. We use a lot of caramalt, some amber malt and some chocolate malt to give the little beer as much body and mouthfeel as possible and the ability to handle all the hops we threw at it. We think this beer is the world’s first ever Imperial Mild. Imperial in terms of hop profile. An Imperially Hopped Mild. BrewDog’s Imperial Mild. How to Disappear Completely.", imageURL: nil),
        WidgetBeerInfo(id: 3, name: "Morag's Mojito - B-Sides", description: "A cunning cocktail blend of grapefruit hops, ginger spice and refreshing mint.", imageURL: nil)
    ]
}
