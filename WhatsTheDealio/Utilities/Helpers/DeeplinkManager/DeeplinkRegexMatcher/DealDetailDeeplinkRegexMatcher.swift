//
//  DealDetailDeeplinkRegexMatcher.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation

struct DealDetailDeeplinkRegexMatcher: DeeplinkRegexMatcher {
    func matchDeeplink(_ path: String) -> Deeplink? {
        guard let match = path.firstMatch(of: /\/deal\/(?<dealID>\d+)/),
              let id = Int(match.dealID)
        else { return nil }

        return .dealDetail(id)
    }
}
