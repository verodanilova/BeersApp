//
//  GetBeersListRequest.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import Foundation


public struct GetBeersListRequest {
    private let perPage: Int
    private let page: Int

    public init(page: Int = 1) {
        self.page = page
        self.perPage = BeersCore.configuration.dataFetchLimit
    }
}

// MARK: - RequestParametersConvertible implementation
extension GetBeersListRequest: RequestParametersConvertible {
    func toRequestParameters() -> [String : Any] {
        return ["page": page, "per_page": perPage]
    }
}
