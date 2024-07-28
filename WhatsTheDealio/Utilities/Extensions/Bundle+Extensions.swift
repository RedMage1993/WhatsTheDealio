//
//  Bundle+Extensions.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation

enum BundleError: Error {
    case noURL
}

extension Bundle {
    func decodeJSON<T: Decodable>(filename: String, using decoder: JSONDecoder = .init()) throws -> T {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json")
        else { throw BundleError.noURL }

        return try decoder.decode(T.self, from: Data(contentsOf: url))
    }
}
