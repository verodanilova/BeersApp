//
//  APIRequest.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import Foundation
import Alamofire


struct APIRequest {
    typealias Headers = [String: String]
    
    var method: HTTPMethod
    var path: String
    var parameters: Parameters = [:]
    var headers: Headers = [:]
    var encoding: ParameterEncoding = URLEncoding.queryString
    var serializer: DataResponseSerializer = DataRequest.jsonResponseSerializer()
    var envelope: ResponseEnvelopeType = ResponseDataEnvelope()

    init(method: HTTPMethod, path: String) {
        self.method = method
        self.path = path
    }
}

extension APIRequest {
    static func requestParameters(_ object: RequestParametersConvertible) -> Parameters {
        return object.toRequestParameters() as Parameters
    }
}
