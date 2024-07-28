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
    
    enum RedirectCheckError: Error {
        case noResponse
        case redirectionNotFound
        case other(Error)
    }

    func checkForRedirect(hostName: String) async throws -> URL {
        let session = URLSession(configuration: .default, delegate: DisabledRedirectURLSession(hostName: hostName), delegateQueue: nil)

        let (_, response) = try await session.data(from: self)

        guard let httpResponse = response as? HTTPURLResponse
        else { throw RedirectCheckError.noResponse }

        if let location = httpResponse.value(forHTTPHeaderField: "Location"),
           let newURL = URL(string: location, relativeTo: self) {
            return newURL
        } else {
            throw RedirectCheckError.redirectionNotFound
        }
    }
}
