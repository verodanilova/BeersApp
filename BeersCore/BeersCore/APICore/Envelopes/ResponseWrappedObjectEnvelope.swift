//
//  ResponseWrappedObjectEnvelope.swift
//  BeersCore
//
//  Created by Veronica Danilova on 22.03.2021.
//

import Foundation

struct ResponseWrappedObjectEnvelope: ResponseEnvelopeType {
    func loadJSON(_ JSON: Any) -> Result<Any> {
        guard let array = JSON as? [Any],
              let wrappedObject = array.first
        else {
            let error = NSError.init(domain: responseEnvelopeErrorDomain,
                code: ResponseEnvelopeErrorCode.invalidJSON.rawValue,
                userInfo: [NSLocalizedDescriptionKey: "Expected wrapped JSON object"])
            return .failure(error)
        }
        return .success(wrappedObject)
    }
}
