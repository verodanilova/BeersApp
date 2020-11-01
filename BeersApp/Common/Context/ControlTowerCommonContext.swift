//
//  ControlTowerCommonContext.swift
//  BeersApp
//
//  Created by Veronica Danilova on 31.10.2020.
//

import Foundation


protocol CommonContext: NavigatorContext {
}

struct ControlTowerCommonContext {
    let navigator: NavigatorType
}

extension ControlTowerCommonContext: CommonContext {
}

