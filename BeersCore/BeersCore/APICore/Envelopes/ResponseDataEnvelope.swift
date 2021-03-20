//
//  ResponseDataEnvelope.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import Foundation


struct ResponseDataEnvelope: ResponseEnvelopeType {
    func loadJSON(_ JSON: Any) -> Result<Any> {
        guard let envelope = JSON as? [String: Any] else {
            return .failure(NSError.init(domain: responseEnvelopeErrorDomain,
                code: ResponseEnvelopeErrorCode.invalidJSON.rawValue,
                userInfo: [NSLocalizedDescriptionKey: "Expected a JSON object."]))
        }

        return .success(envelope)
    }
}
