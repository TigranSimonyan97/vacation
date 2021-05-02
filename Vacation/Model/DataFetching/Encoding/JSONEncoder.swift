//
//  JSONEncoder.swift
//  Vacation
//
//  Created by Tigran Simonyan on 5/2/21.
//

import Foundation

class JSONEncoder: DataFetchingEncoding {
    func encode(request: URLRequest, with params: [String : Any]) -> URLRequest {
        return request
    }
}
