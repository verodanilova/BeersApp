//
//  AppConfiguration.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import Foundation


enum ConfigurationStrings: String {
    case apiBaseURI = "https://api.punkapi.com/v2"
}

struct AppConfiguration {
    let apiBaseURL: URL = fetchURL(.apiBaseURI)
}

private extension AppConfiguration {
    static func fetchURL(_ key: ConfigurationStrings) -> URL {
        if let value = URL(string: key.rawValue) {
            return value
        }

        preconditionFailure("A value for the key <\(key.rawValue)> must be an URL.")
    }
}

let appConfiguration = AppConfiguration()
