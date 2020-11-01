//
//  ContextProvider.swift
//  BeersApp
//
//  Created by Veronica Danilova on 01.11.2020.
//

import Foundation


protocol ContextProvider {
    func provideContext<C>() -> C?
}

final class CommonContextProvider: ContextProvider {
    var context: CommonContext?

    func provideContext<T>() -> T? {
        return self.context as? T
    }
}
