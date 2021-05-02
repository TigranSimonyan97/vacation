//
//  JSONFileFetcher.swift
//  Vacation
//
//  Created by Tigran Simonyan on 5/2/21.
//

import Foundation
import Combine

class JSONFileFetcher: DataFetching {
    func fetch(_ route: Routing) -> AnyPublisher<Validatable, Error> {
        return Future { [ weak self ] promise in
            guard let strongSelf = self else {
                promise(.failure(ServiceError.custom(message: "Missing self", serviceKey: route.key)))
                    
                return
            }
            
            let bundle = Bundle.main
            guard let path = bundle.path(forResource: route.key, ofType: "json") else {
                promise(.failure(ServiceError.missingJSON(serviceKey: route.key)))
                
                return
            }
            
            let url = URL(fileURLWithPath: path)
            
            do {
                let data = try Data(contentsOf: url)
                let validator = strongSelf.validatorProvider.provide(route.key, nil, data)
                
                promise(.success(validator))
            } catch let error {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func download(_ route: Routing) -> AnyPublisher<Data, Error> {
        return Future { promise in            
            let bundle = Bundle.main
            guard let path = bundle.path(forResource: route.key, ofType: "json") else {
                promise(.failure(ServiceError.missingJSON(serviceKey: route.key)))
                
                return
            }
            
            let url = URL(fileURLWithPath: path)
            
            do {
                let data = try Data(contentsOf: url)
                
                promise(.success(data))
            } catch let error {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()

    }
}
