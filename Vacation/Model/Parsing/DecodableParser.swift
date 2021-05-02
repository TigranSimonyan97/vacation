//
//  DecodableParser.swift
//  Vacation
//
//  Created by Tigran Simonyan on 5/2/21.
//

import Foundation
import Combine

// TODO: Remove parse methods duplication

class DecodableParser: Parsable {
    var service: String
    var data: Data?
    var entity: Any?
    
    var parsingCompletion: ((Any?) -> Void)?
    
    required init(service: String, data: Data? = nil, entity: Any? = nil) {
        self.service = service
        self.data = data
        self.entity = entity
    }
    
    func parse<T: Decodable>() -> Future<T, Error> {
        return Future { [ weak self ] promise in
            guard let strongSelf = self else {
                promise(.failure(ServiceError.custom(message: "Missing self", serviceKey: nil)))
                
                return
            }

            if let entity = strongSelf.entity as? T {
                promise(.success(entity))
            } else {
                if let data = strongSelf.data {
                    do {
                        let parsedData = try T.decode(from: data)
                        promise(.success(parsedData))
                    } catch let error {
                        promise(.failure(error))
                    }
                } else {
                    let error = ServiceError.missingData(serviceKey: strongSelf.service)
                    promise(.failure(error))
                }
            }
        }
    }
        
    func parse<T, V : Decodable>(_ rootType: V.Type) -> Future<T, Error> where T == V.T, V : DataRetrievable {
        return Future { [ weak self ] promise in
            guard let strongSelf = self else {
                promise(.failure(ServiceError.custom(message: "Missing self", serviceKey: nil)))
                
                return
            }

            if let entity = strongSelf.entity as? T {
                promise(.success(entity))
            } else {
                if let data = strongSelf.data {
                    do {
                        let parsedData = try V.decode(from: data)
                        promise(.success(parsedData.data))
                    } catch let error {
                        promise(.failure(error))
                    }
                } else {
                    let error = ServiceError.missingData(serviceKey: strongSelf.service)
                    promise(.failure(error))
                }
            }
        }
    }
    
    func parseArray<T : Decodable>() -> Future<[T], Error> {
        return Future { [ weak self ] promise in
            guard let strongSelf = self else {
                promise(.failure(ServiceError.custom(message: "Missing self", serviceKey: nil)))
                
                return
            }

            if let entity = strongSelf.entity as? [T] {
                promise(.success(entity))
            } else {
                if let data = strongSelf.data {
                    do {
                        let parsedData = try T.decodeArray(from: data)
                        promise(.success(parsedData))
                    } catch let error {
                        promise(.failure(error))
                    }
                } else {
                    let error = ServiceError.missingData(serviceKey: strongSelf.service)
                    promise(.failure(error))
                }
            }
        }
    }
    
    func parseArray<T, V : Decodable>(_ rootType: V.Type) -> Future<[T], Error> where T == V.T, V : ArrayDataRetrievable {
        return Future { [ weak self ] promise in
            guard let strongSelf = self else {
                promise(.failure(ServiceError.custom(message: "Missing self", serviceKey: nil)))
                
                return
            }
            
            if let entity = strongSelf.entity as? [T] {
                promise(.success(entity))
            } else {
                if let data = strongSelf.data {
                    do {
                        let parsedData = try V.decode(from: data)
                        promise(.success(parsedData.data))
                    } catch let error {
                        promise(.failure(error))
                    }
                } else {
                    let error = ServiceError.missingData(serviceKey: strongSelf.service)
                    promise(.failure(error))
                }
            }
        }
    }
}

