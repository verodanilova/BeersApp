//
//  AppConfiguration.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import BeersCore


struct AppConfiguration: AppConfigurationType {
    let apiBaseURL: URL = fetchURL(.apiBaseURI)
    let persistentStackModelName = ConfigurationStrings.persistentStackModelName.rawValue
    let dataFetchLimit: Int = 30
}

private extension AppConfiguration {
    static func fetchURL(_ key: ConfigurationStrings) -> URL {
        if let value = URL(string: key.rawValue) {
            return value
        }

        preconditionFailure("A value for the key <\(key.rawValue)> must be an URL.")
    }
}
