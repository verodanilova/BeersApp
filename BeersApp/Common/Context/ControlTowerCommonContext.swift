//
//  ControlTowerCommonContext.swift
//  BeersApp
//
//  Created by Veronica Danilova on 31.10.2020.
//

import Foundation


protocol CommonContext: NavigatorContext,
    BeersAPIContext {
}

struct ControlTowerCommonContext {
    let navigator: NavigatorType
    let beersAPI: BeersAPI
}

extension ControlTowerCommonContext: CommonContext {
}

