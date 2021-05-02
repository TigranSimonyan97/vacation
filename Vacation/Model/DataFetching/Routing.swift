//
//  Routing.swift
//  Vacation
//
//  Created by Tigran Simonyan on 5/2/21.
//

import Foundation

protocol Routing {
    var key: String { get }
    
    var headers: [String: String] { get }
    var params: [String: Any] { get }
    var method: HTTPMethod { get }
    var encoder: DataFetchingEncoding { get }
    var acceptableStatusCodes: Set<Int> { get }
    var cachingType: CachePolicy { get }
    
    var url: URL { get }
    var request: URLRequest { get }
}

extension Routing {
    var url: URL { return URL(string: "firebase url")! }
    var params: [String: Any] { return [:] }
    var headers: [String: String] { return [:] }
    var method: HTTPMethod { return .get }
    var encoder: DataFetchingEncoding { return URLEncoder() }
    var acceptableStatusCodes: Set<Int> { return [] }
    var cachingType: CachePolicy { return .session }
    
    var request: URLRequest {
        var request = URLRequest(url: url)
        
        for header in headers {
            request.setValue(header.key, forHTTPHeaderField: header.value)
        }
        
        request.httpMethod = method.rawValue
        
        request = encoder.encode(request: request, with: params)
        
        return request
    }
}

enum CachePolicy {
    case app
    case session
    case none
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
