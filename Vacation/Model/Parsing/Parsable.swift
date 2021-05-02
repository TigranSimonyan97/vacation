//
//  Parsable.swift
//  Vacation
//
//  Created by Tigran Simonyan on 5/2/21.
//

import Foundation
import Combine

protocol Parsable {
    var service: String { get }
    var data: Data? { get }
    var entity: Any? { get set }
    
    var parsingCompletion: ((Any?) -> Void)? { get }
    
    init(service: String, data: Data?, entity: Any?)
    
    func parse<T: Decodable>() -> Future<T, Error>
    func parse<T, V: Decodable>(_ rootType: V.Type) -> Future<T, Error> where V: DataRetrievable, V.T == T
    func parseArray<T: Decodable>() -> Future<[T], Error>
    func parseArray<T, V: Decodable>(_ rootType: V.Type) -> Future<[T], Error> where V: ArrayDataRetrievable, V.T == T
}
