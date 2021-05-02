//
//  DataFetchingEncoding.swift
//  Vacation
//
//  Created by Tigran Simonyan on 5/2/21.
//

import Foundation

protocol DataFetchingEncoding {
    func encode(request: URLRequest, with params: [String : Any]) -> URLRequest
}

