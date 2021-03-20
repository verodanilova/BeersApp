//
//  CommonAPI.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import RxSwift


public protocol CommonAPI {
    func executeRequest<T: InsertableFromJSON>(_ request: APIRequest) -> Observable<T>
}
