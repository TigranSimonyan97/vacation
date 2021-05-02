//
//  DataFetching.swift
//  Vacation
//
//  Created by Tigran Simonyan on 5/2/21.
//

import Foundation
import Combine

protocol DataFetching {
    var validatorProvider: (_ service: String, _ response: URLResponse?, _ data: Data?) -> Validatable { get }
    var validatorProviderWithEntity: (_ service: String, _ entity: Any) -> Validatable { get }
    
    func fetch(_ route: Routing) -> AnyPublisher<Validatable, Error>
    func download(_ route: Routing) -> AnyPublisher<URL, Error>
}
