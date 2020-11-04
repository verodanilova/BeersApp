//
//  Contexts.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import Foundation


protocol NavigatorContext {
    var navigator: NavigatorType {get}
}

protocol BeersAPIContext {
    var beersAPI: BeersAPI {get}
}
