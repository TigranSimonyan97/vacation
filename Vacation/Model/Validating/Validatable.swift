//
//  Validatable.swift
//  Vacation
//
//  Created by Tigran Simonyan on 5/2/21.
//

import Foundation
import Combine

protocol Validatable {
    var parserProvider: (_ service: String, _ data: Data?, _ entity: Any?) -> Parsable { get }
    
    var service: String { get }
    var data: Data? { get }
    var entity: Any? { get set }

    init(service: String, response: URLResponse?, data: Data?)
    init(service: String, entity: Any)

    func withoutValidation() -> Future<Parsable, Error>
    func validate<T: Decodable>(_ handler: @escaping ((T, String, Int?) -> Error?)) -> Future<Parsable, Error>
}

