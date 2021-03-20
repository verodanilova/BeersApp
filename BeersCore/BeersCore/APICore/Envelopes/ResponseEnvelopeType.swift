//
//  ResponseEnvelopeType.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import Foundation
import Alamofire


typealias Result<T> = Alamofire.Result<T>
let responseEnvelopeErrorDomain = "ResponseEnvelopeErrorDomain"
enum ResponseEnvelopeErrorCode: Int {
    /** Envelope structure is incorrect. */
    case invalidJSON
}

protocol ResponseEnvelopeType {
    func loadJSON(_ JSON: Any) -> Result<Any>
}
