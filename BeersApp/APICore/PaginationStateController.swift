//
//  PaginationStateController.swift
//  BeersApp
//
//  Created by Veronica Danilova on 10.11.2020.
//

import Foundation


protocol PaginationStateControllerType {
    var nextPage: Int {get}
    var isPaginationEnabled: Bool {get}
    
    func setStoredItems(_ items: [Any])
    func newLoadedItems(_ items: [Any])
    func resetState()
}

final class PaginationStateController: PaginationStateControllerType {
    private var itemsCount: Int = 0
    private var lastLoadedItemsResult: [Any]?
    private let dataFetchLimit = appConfiguration.dataFetchLimit
    
    var isPaginationEnabled: Bool {
        if let lastItemsResult = lastLoadedItemsResult {
            return lastItemsResult.count == dataFetchLimit
        } else {
            return true
        }
    }
    
    var nextPage: Int {
        return (itemsCount / dataFetchLimit) + 1
    }
    
    func setStoredItems(_ items: [Any]) {
        itemsCount = items.count
    }

    func newLoadedItems(_ items: [Any]) {
        lastLoadedItemsResult = items
    }
    
    func resetState() {
        itemsCount = 0
        lastLoadedItemsResult = nil
    }
}
