//
//  APIClient.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import Foundation
import Alamofire
import RxSwift
import CoreData


public final class APIClient {
    private let baseURL: URL
    private let managedObjectContext: NSManagedObjectContext
    private let networkSession: SessionManager

    public init(baseURL: URL, managedObjectContext: NSManagedObjectContext) {
        let sessionConfiguration = URLSessionConfiguration.default
        let policyManager = ServerTrustPolicyManager(policies: [:])
        self.networkSession = SessionManager(configuration: sessionConfiguration,
            serverTrustPolicyManager: policyManager)
        self.networkSession.startRequestsImmediately = false
        self.baseURL = baseURL
        self.managedObjectContext = managedObjectContext
    }
}

// MARK: - Common API conformance
extension APIClient: CommonAPI {
    public func executeRequest<T: InsertableFromJSON>(_ request: APIRequest) -> Observable<T> {
        return Observable.create { observer -> Disposable in
            let task = self.executeRequest(request, type: T.self,
                completionHandler: self.requestCompletionHandler(observer: observer))
            return Disposables.create {
                    task.cancel()
                }
        }
    }
}

// MARK: - Execute requests
private extension APIClient {
    func executeRequest<T: InsertableFromJSON>(_ request: APIRequest, type: T.Type,
        completionHandler: @escaping (Result<T>) -> Void) -> CancelableTask {
        let headers = headersForRequest(request)
        let uri = objectURI(path: request.path)
        let parameters = request.parameters
        return executeInsertableObjectRequest(context: managedObjectContext,
            method: request.method, URL: uri, parameters: parameters, headers: headers,
            objectType: type, envelope: request.envelope, serializer: request.serializer,
            encoding: request.encoding, completionHandler: completionHandler)
    }
    
    func executeInsertableObjectRequest<Object: InsertableFromJSON>(
        context: NSManagedObjectContext, method: HTTPMethod,
        URL: URLConvertible, parameters: Parameters,
        headers: HTTPHeaders?, objectType: Object.Type, envelope: ResponseEnvelopeType,
        serializer: DataResponseSerializer<Any>, encoding: ParameterEncoding,
        completionHandler: @escaping (Result<Object>) -> Void) -> Request {

        let request = networkSession.request(URL, method: method, parameters: parameters,
            encoding: encoding, headers: headers)

        request.resume()

        return request.responseInsertable(context: context, serializer: serializer,
            objectType: objectType, envelope: envelope) { response in
                completionHandler(response.result)
            }
    }
    
    func requestCompletionHandler<T>(observer: AnyObserver<T>) -> (Result<T>) -> Void {
        return { result in
                switch result {
                    case .success(let value):
                        observer.on(.next(value))
                        observer.on(.completed)
                    case .failure(let error):
                        observer.on(.error(error))
                }
            }
    }
}

// MARK: - Helpers
private extension APIClient {
    func objectURI(path: String) -> URL {
        return baseURL.appendingPathComponent(path)
    }
    
    func headersForRequest(_ request: APIRequest) -> HTTPHeaders? {
        var headers = request.headers
        headers["Accept"] = "application/json"
        return headers
    }
}
