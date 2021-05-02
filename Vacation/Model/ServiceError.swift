//
//  ServiceError.swift
//  Vacation
//
//  Created by Tigran Simonyan on 5/2/21.
//

import Foundation

enum ServiceError: Error {
    case missingData(serviceKey: String)
    case custom(message: String, serviceKey: String?)
}
