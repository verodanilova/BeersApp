//
//  PaginationStateControllerType.swift
//  BeersCore
//
//  Created by Veronica Danilova on 20.03.2021.
//

public protocol PaginationStateControllerType {
    var nextPage: Int {get}
    var isPaginationEnabled: Bool {get}
    
    func setStoredItems(_ items: [Any])
    func newLoadedItems(_ items: [Any])
    func resetState()
}
