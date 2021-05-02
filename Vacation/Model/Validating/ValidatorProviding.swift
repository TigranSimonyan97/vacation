//
//  ValidatorProviding.swift
//  Vacation
//
//  Created by Tigran Simonyan on 5/2/21.
//

import Foundation

protocol ValidatorProviding {
    var provide: (_ service: String, _ response: URLResponse?, _ data: Data?) -> Validatable { get }
    var provideWithEntity: (_ service: String, _ entity: Any) -> Validatable { get }
}

class DefaultValidatorProvider: ValidatorProviding {
    var provide: (String, URLResponse?, Data?) -> Validatable = { (service, response , data) in
        return DefaultValidator(service: service, response: response, data: data)
    }
    
    var provideWithEntity: (String, Any) -> Validatable = { (service, entity) in
        return DefaultValidator(service: service, entity: entity)
    }
    
}
