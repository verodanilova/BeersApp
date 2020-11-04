//
//  DataRequest+InsertableFromJSON.swift
//  BeersApp
//
//  Created by Veronica Danilova on 04.11.2020.
//

import Foundation
import Alamofire
import CoreData


// MARK: - DataRequest extension for Insertable objects
extension DataRequest {
    @discardableResult
    func responseInsertable<T: InsertableFromJSON>(
        context: NSManagedObjectContext, serializer: DataResponseSerializer<Any>,
        objectType: T.Type, envelope: ResponseEnvelopeType,
        completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        /* Construct a serializer for context-insertable objects and use it as the response serializer. */
        let insertableSerializer = insertableResponseSerializer(context: context,
            serializer: serializer, objectType: objectType, envelope: envelope)

        return response(responseSerializer: insertableSerializer,
            completionHandler: completionHandler)
    }
}

private extension DataRequest {
    func insertableResponseSerializer<T: InsertableFromJSON>(
        context: NSManagedObjectContext, serializer: DataResponseSerializer<Any>,
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
                        try DataRequest.saveInsertedObjects(in: context)
                        return .success(object)
                    } catch {
                        /* Should clean the current stack to prevent the next attempting to save to the
                         context when the stack has the last insertion with unsaved data
                         */
                        context.rollback()
                        
                        return .failure(InsertableFromJSONError.insertError(error))
                    }
                    
                case .failure(let error):
                    return .failure(InsertableFromJSONError.serializingError(error))
            }
        })
    }


    /* Save inserted objects to the persistent store.
    
      Store the inserted objects into the context, and then into all parent contexts up the context
      chain.
    */
    static func saveInsertedObjects(in context: NSManagedObjectContext) throws {
        context.performAndWait {
            do {
                let insertedObjects = Array(context.insertedObjects)
                try context.obtainPermanentIDs(for: insertedObjects)
                try context.save()
            } catch {
                print("Error happened during saving inserted objects: \(error)")
            }
        }
    }
}

