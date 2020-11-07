//
//  GetBeersListRequest.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import Foundation


struct GetBeersListRequest {
    private let perPage: Int = appConfiguration.dataFetchLimit
    private let page: Int

    init(page: Int = 1) {
        self.page = page
    }
}

// MARK: - RequestParametersConvertible implementation
extension GetBeersListRequest: RequestParametersConvertible {
    func toRequestParameters() -> [String : Any] {
        return ["page": page, "per_page": perPage]
    }
}
