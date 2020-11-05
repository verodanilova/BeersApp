//
//  BeersAPI.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import Foundation
import RxSwift
import Alamofire


protocol BeersAPI: CommonAPI {
    func getBeersList(_ input: GetBeersListRequest) -> Observable<[BeerInfo]>
}

extension APIClient: BeersAPI {}

extension BeersAPI {
    func getBeersList(_ input: GetBeersListRequest) -> Observable<[BeerInfo]> {
        var request = APIRequest(method: .get, path: "/beers")
        request.parameters = APIRequest.requestParameters(input)
        request.envelope = ResponseRootArrayEnvelope()
        return executeRequest(request)
    }
}
