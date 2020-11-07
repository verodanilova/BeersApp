//
//  ResponseRootArrayEnvelope.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import Foundation


struct ResponseRootArrayEnvelope: ResponseEnvelopeType {
    func loadJSON(_ JSON: Any) -> Result<Any> {
        guard let array = JSON as? [Any] else {
            let error = NSError.init(domain: responseEnvelopeErrorDomain,
                code: ResponseEnvelopeErrorCode.invalidJSON.rawValue,
                userInfo: [NSLocalizedDescriptionKey: "Expected root JSON object as Array type"])
            return .failure(error)
        }
        return .success(array)
    }
}
