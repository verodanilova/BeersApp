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
    func getBeersList(_ input: GetBeersListRequest) -> Observable<NoContent>
}

extension APIClient: BeersAPI {}

extension BeersAPI {
    func getBeersList(_ input: GetBeersListRequest) -> Observable<NoContent> {
        var request = APIRequest(method: .get, path: "/beers")
        request.parameters = APIRequest.requestParameters(input)
        request.envelope = ResponseRootArrayEnvelope()
        return executeRequest(request)
    }
}
