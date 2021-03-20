//
//  AppConfigurationType.swift
//  BeersCore
//
//  Created by Veronica Danilova on 20.03.2021.
//

public protocol AppConfigurationType {
    var apiBaseURL: URL { get }
    var persistentStackModelName: String { get }
    var dataFetchLimit: Int { get }
}
