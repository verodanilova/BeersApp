//
//  BeersCore.swift
//  BeersCore
//
//  Created by Veronica Danilova on 20.03.2021.
//

import Foundation

public class BeersCore {
    static var configuration: AppConfigurationType {
        guard let configuration = BeersCore.appConfiguration else {
            fatalError("Beers Core has no configuration")
        }
        return configuration
    }
    
    static var bundle: Bundle {
        guard let bundle = Bundle(identifier: "verodanilova.BeersCore") else {
            fatalError("Beers Core bundle ID is incorrect")
        }
        return bundle
    }
    
    private static var appConfiguration: AppConfigurationType?
    
    public static func configure(with configuration: AppConfigurationType) {
        self.appConfiguration = configuration
    }
}
