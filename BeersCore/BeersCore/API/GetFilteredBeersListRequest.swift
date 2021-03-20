//
//  GetFilteredBeersListRequest.swift
//  BeersApp
//
//  Created by Veronica Danilova on 10.11.2020.
//

import Foundation


public struct GetFilteredBeersListRequest {
    private let storage: BeerFiltersStorageType
    private let page: Int
    private let perPage: Int = BeersCore.configuration.dataFetchLimit
    
    public init(storage: BeerFiltersStorageType, page: Int = 1) {
        self.storage = storage
        self.page = page
    }
}

// MARK: - RequestParametersConvertible implementation
extension GetFilteredBeersListRequest: RequestParametersConvertible {
    func toRequestParameters() -> [String : Any] {
        var params: [String: Any] = ["page": page, "per_page": perPage]
        if let alcoholLowerValue = storage.alcoholLowerValue {
            params["abv_gt"] = Double(round(10 * alcoholLowerValue)/10)
        }
        if let alcoholUpperValue = storage.alcoholUpperValue {
            params["abv_lt"] = Double(round(10 * alcoholUpperValue)/10)
        }
        if let bitternessLowerValue = storage.bitternessLowerValue {
            params["ibu_gt"] = Int(bitternessLowerValue)
        }
        if let bitternessUpperValue = storage.bitternessUpperValue {
            params["ibu_lt"] = Int(bitternessUpperValue)
        }
        if let colorLowerValue = storage.colorLowerValue {
            params["ebc_gt"] = Int(colorLowerValue)
        }
        if let colorUpperValue = storage.colorUpperValue {
            params["ebc_lt"] = Int(colorUpperValue)
        }
        return params
    }
}

