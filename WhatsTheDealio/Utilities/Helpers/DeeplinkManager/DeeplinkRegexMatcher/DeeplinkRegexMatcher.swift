//
//  DeeplinkRegexMatcher.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation

protocol DeeplinkRegexMatcher {
    func matchDeeplink(_ path: String) -> Deeplink?
}
