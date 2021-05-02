//
//  DataFetching.swift
//  Vacation
//
//  Created by Tigran Simonyan on 5/2/21.
//

import Foundation
import Combine

protocol DataFetching {

    var validatorProvider: ValidatorProviding { get }
        
    func fetch(_ route: Routing) -> AnyPublisher<Validatable, Error>
    func download(_ route: Routing) -> AnyPublisher<Data, Error>
}


extension DataFetching {
    var validatorProvider: ValidatorProviding {
        return DefaultValidatorProvider()
    }
}
