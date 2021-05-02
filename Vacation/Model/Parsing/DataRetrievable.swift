//
//  DataRetrievable.swift
//  Vacation
//
//  Created by Tigran Simonyan on 5/2/21.
//

import Foundation

protocol DataRetrievable {
    associatedtype T: Decodable
    
    var data: T { get }
}

protocol ArrayDataRetrievable {
    associatedtype T: Decodable
    
    var data: [T] { get }
}
