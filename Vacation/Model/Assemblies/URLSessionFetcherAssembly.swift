//
//  URLSessionFetcherAssembly.swift
//  Vacation
//
//  Created by Tigran Simonyan on 5/2/21.
//

import Foundation
import Swinject

final class URLSessionFetcherAssembly: Assembly {
    func assemble(container: Container) {
        container.register(DataFetching.self) { _ in
            return URLSessionFetcher()
        }
    }
}
