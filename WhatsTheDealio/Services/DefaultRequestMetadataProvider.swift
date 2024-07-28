//
//  DefaultRequestMetadataProvider.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation
import Networking

class DefaultRequestMetadataProvider: RequestMetadataProvider {
    func globalHeaders() async throws -> [String: Any]? {
        [
            "x-demo-header": "demo"
        ]
    }

	func globalParameters() async throws -> [URLQueryItem]? {
		nil
	}
}
