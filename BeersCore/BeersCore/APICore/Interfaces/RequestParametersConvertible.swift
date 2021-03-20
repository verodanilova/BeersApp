//
//  RequestParametersConvertible.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import Foundation


protocol RequestParametersConvertible {
    /** Convert the instance to API compatible parameters dictionary. */
    func toRequestParameters() -> [String: Any]
}
