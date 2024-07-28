//
//  DeeplinkManager.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation

@Observable
class DeeplinkManager {
    private let appScheme: String
    private let hostName: String
    private let regexMatchers: [DeeplinkRegexMatcher]
    
    private(set) var deeplink: Deeplink?

    private let deeplinkConsumer = Consumer()
    
    init(appScheme: String, hostName: String, regexMatchers: [DeeplinkRegexMatcher]) {
        self.appScheme = appScheme
        self.hostName = hostName
        self.regexMatchers = regexMatchers
    }

    func consumeDeeplink(_ consumption: (Deeplink) async -> Bool) async {
        await deeplinkConsumer.consumeDeeplink(&deeplink, consumption: consumption)
    }

    func parseURL(_ url: URL) async throws {
        let modifiedURL = url.scheme == appScheme ? url.movingHostToPath() : url

        if modifiedURL.scheme?.hasPrefix("http") == true {
            self.deeplink = try await processHTTPURL(modifiedURL)
        } else {
            self.deeplink = matchDeeplink(in: modifiedURL)
        }
    }

    private func processHTTPURL(_ url: URL) async throws -> Deeplink? {
        let deepLink = matchDeeplink(in: url)

        guard deepLink == nil else { return deepLink }

        let redirectedURL = try await url.checkForRedirect(hostName: hostName)

        return try await processHTTPURL(redirectedURL)
    }

    private func matchDeeplink(in url: URL) -> Deeplink? {
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)

        guard let path = urlComponents?.path else { return nil }

        for regexMatcher in regexMatchers {
            guard let deeplink = regexMatcher.matchDeeplink(path) else { continue }
            return deeplink
        }

        return nil
    }

    actor Consumer {
        func consumeDeeplink(_ deeplink: inout Deeplink?, consumption: (Deeplink) async -> Bool) async {
            guard let validDeeplink = deeplink else { return }

            let consumed = await consumption(validDeeplink)

            guard consumed else { return }

            deeplink = nil
        }
    }
}
