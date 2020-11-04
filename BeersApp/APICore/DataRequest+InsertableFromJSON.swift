//
//  DataRequest+InsertableFromJSON.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import Foundation
import Alamofire


// MARK: - DataRequest extension for Insertable objects
extension DataRequest {
    @discardableResult
    func responseInsertable<T: InsertableFromJSON>(
        serializer: DataResponseSerializer<Any>,
        objectType: T.Type, envelope: ResponseEnvelopeType,
        completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        /* Construct a serializer for context-insertable objects and use it as the response serializer. */
        let insertableSerializer = insertableResponseSerializer(
            serializer: serializer, objectType: objectType, envelope: envelope)

        return response(responseSerializer: insertableSerializer,
            completionHandler: completionHandler)
    }
}

private extension DataRequest {
    func insertableResponseSerializer<T: InsertableFromJSON>(
        serializer: DataResponseSerializer<Any>,
        objectType: T.Type, envelope: ResponseEnvelopeType) -> DataResponseSerializer<T> {
        return DataResponseSerializer(serializeResponse: {
            (request, response, data, error) -> Result<T> in
            let initialResult = serializer.serializeResponse(request, response, data, error)
            switch initialResult {
                case .success(let value):
                    let unpackedResult = envelope.loadJSON(value)
                    guard case .success(let unpackedValue) = unpackedResult else {
                        return .failure(unpackedResult.error!)
                    }

                    do {
                        let object = try T.insertObject(fromJSON: unpackedValue)
                        
                        return .success(object)
                    } catch {
                        
                        return .failure(InsertableFromJSONError.insertError(error))
                    }
                    
                case .failure(let error):
                    return .failure(InsertableFromJSONError.serializingError(error))
            }
        })
    }

}
