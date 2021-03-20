//
//  CancelableTask.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import Foundation
import Alamofire


protocol CancelableTask {
   func cancel()
}

extension Alamofire.Request: CancelableTask {
}
