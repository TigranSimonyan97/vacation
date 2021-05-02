//
//  Entity+Decodable.swift
//  Vacation
//
//  Created by Tigran Simonyan on 5/2/21.
//

import Foundation

extension Decodable {
    static func decode(from data: Data) throws -> Self {
        let decoder = JSONDecoder()
        let data = try decoder.decode(Self.self, from: data)
        
        return data
    }

    static func decodeArray(from data: Data) throws -> [Self] {
        let decoder = JSONDecoder()
        let data = try decoder.decode([Self].self, from: data)
        
        return data
    }
}
