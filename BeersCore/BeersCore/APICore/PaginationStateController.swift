//
//  PaginationStateController.swift
//  BeersApp
//
//  Created by Veronica Danilova on 10.11.2020.
//

import Foundation

public final class PaginationStateController: PaginationStateControllerType {
    private var itemsCount: Int = 0
    private var lastLoadedItemsResult: [Any]?
    private let dataFetchLimit = BeersCore.configuration.dataFetchLimit
    
    public var isPaginationEnabled: Bool {
        if let lastItemsResult = lastLoadedItemsResult {
            return lastItemsResult.count == dataFetchLimit
        } else {
            return true
        }
    }
    
    public var nextPage: Int {
        return (itemsCount / dataFetchLimit) + 1
    }
    
    public init() {}
    
    public func setStoredItems(_ items: [Any]) {
        itemsCount = items.count
    }

    public func newLoadedItems(_ items: [Any]) {
        lastLoadedItemsResult = items
    }
    
    public func resetState() {
        itemsCount = 0
        lastLoadedItemsResult = nil
    }
}
