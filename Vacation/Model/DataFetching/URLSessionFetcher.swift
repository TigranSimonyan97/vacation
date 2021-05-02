//
//  URLSessionFetcher.swift
//  Vacation
//
//  Created by Tigran Simonyan on 5/2/21.
//

import Foundation
import Combine

class URLSessionFetcher: DataFetching {
    
    func fetch(_ route: Routing) -> AnyPublisher<Validatable, Error> {
        // try to find in cache, othervise fetch using url request
        return URLSession.shared.dataTaskPublisher(for: route.request).tryMap { [ weak self ] (data , response) -> Validatable in
            guard let strongSelf = self else { throw(ServiceError.custom(message: "Missing Self", serviceKey: nil)) }
            
            // TODO: Handle errors
            return strongSelf.validatorProvider.provide(route.key, response, data)
        }.eraseToAnyPublisher()
    }
    
    func download(_ route: Routing) -> AnyPublisher<Data, Error> {
        // try to find in cache, othervise fetch using url request
        return URLSession.shared.dataTaskPublisher(for: route.request).tryMap { (data, _) -> Data in
            // TODO: Handle errors

            return data
        }.eraseToAnyPublisher()
    }
}
