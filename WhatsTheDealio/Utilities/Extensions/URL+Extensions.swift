//
//  URL+Extensions.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation

extension URL {
    func movingHostToPath() -> URL {
        guard let hostname = host else { return self }

        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return self }

        components.host = nil
        components.path = "/\(hostname)\(components.path)"

        return components.url ?? self
    }
}
