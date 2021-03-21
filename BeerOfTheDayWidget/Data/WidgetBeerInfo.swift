//
//  WidgetBeerInfo.swift
//  BeersApp
//
//  Created by Veronica Danilova on 20.03.2021.
//

import Foundation

struct WidgetBeerInfo: Hashable, Decodable {
    let id: Int
    let name: String
    let description: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(id: Int, name: String, description: String? = nil, imageURL: URL? = nil) {
        self.id = id
        self.name = name
        self.description = description ?? ""
        self.imageURL = imageURL
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case imageURL = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let id = try? container.decode(Int.self, forKey: .id),
            let name = try? container.decode(String.self, forKey: .name) else {
            throw NSError()
        }
        
        let description = try? container.decode(String.self, forKey: .description)
        let imageURLString = try? container.decode(String.self, forKey: .imageURL)
        var imageURL: URL?
        if let imageURLString = imageURLString {
            imageURL = URL(string: imageURLString)
        }
        self.init(id: id, name: name, description: description, imageURL: imageURL)
    }
}
