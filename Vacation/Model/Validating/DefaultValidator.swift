//
//  DefaultValidator.swift
//  Vacation
//
//  Created by Tigran Simonyan on 5/2/21.
//

import Foundation
import Combine

class DefaultValidator: Validatable {
    var parserProvider: (String, Data?, Any?) -> Parsable = { (service, data, entity) in
        return DecodableParser(service: service, data: data, entity: entity)
    }
    
    var service: String
    var data: Data?
    var entity: Any?
    
    var response: URLResponse?
    
    required init(service: String, response: URLResponse?, data: Data?) {
        self.response = response
        self.data = data
        self.service = service
    }
    
    required init(service: String, entity: Any) {
        self.entity = entity
        self.service = service
    }
    
    func withoutValidation() -> Future<Parsable, Error> {
        return Future { [ weak self ] promise in
            guard let strongSelf = self else {
                promise(.failure(ServiceError.custom(message: "Missing Self", serviceKey: nil)))
                
                return
            }
            
            let parser = DecodableParser(service: strongSelf.service, data: strongSelf.data, entity: strongSelf.entity)
            promise(.success(parser))
        }
    }
    
    // TODO: Remove decoding duplication
    func validate<T : Decodable>(_ handler: @escaping ((T, String, Int?) -> Error?)) -> Future<Parsable, Error> {
        return Future { [ weak self ] promise in
            guard let strongSelf = self else {
                promise(.failure(ServiceError.custom(message: "Missing Self", serviceKey: nil)))
                
                return
            }
            
            let parser = DecodableParser(service: strongSelf.service)
            
            if let entity = strongSelf.entity {
                parser.entity = entity
            } else {
                if let data = strongSelf.data {
                    do {
                        let parsedData = try T.decode(from: data)
                        let httpResponse = strongSelf.response as? HTTPURLResponse
                        let code = httpResponse?.statusCode
                        
                        if let error = handler(parsedData, strongSelf.service, code) {
                            promise(.failure(error))
                        } else {
                            parser.entity = parsedData
                        }
                    } catch let error {
                        promise(.failure(error))
                    }
                } else {
                    promise(.failure(ServiceError.missingData(serviceKey: strongSelf.service)))
                }
                
            }
            
            promise(.success(parser))
        }
    }
}
