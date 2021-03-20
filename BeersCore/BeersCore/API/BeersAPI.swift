//
//  BeersAPI.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import Foundation
import RxSwift
import Alamofire


public protocol BeersAPI: CommonAPI {
    func getBeersList(_ input: GetBeersListRequest) -> Single<[BeerInfo]>
    func getFilteredBeersList(_ input: GetFilteredBeersListRequest) -> Single<[BeerInfo]>
}

extension APIClient: BeersAPI {}

public extension BeersAPI {
    func getBeersList(_ input: GetBeersListRequest) -> Single<[BeerInfo]> {
        var request = APIRequest(method: .get, path: "/beers")
        request.parameters = APIRequest.requestParameters(input)
        request.envelope = ResponseRootArrayEnvelope()
        return executeRequest(request).asSingle()
    }
    
    func getFilteredBeersList(_ input: GetFilteredBeersListRequest) -> Single<[BeerInfo]> {
        var request = APIRequest(method: .get, path: "/beers")
        request.parameters = APIRequest.requestParameters(input)
        request.envelope = ResponseRootArrayEnvelope()
        return executeRequest(request).asSingle()
    }
}
