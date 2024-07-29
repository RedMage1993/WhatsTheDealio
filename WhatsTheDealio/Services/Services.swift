//
//  Services.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation
import Networking

final class Services {
    static let shared = Services()

    private let requestBaseURLProvider: RequestBaseURLProvider
    private let metadataProvider: RequestMetadataProvider
    private let requestBuilder: RequestBuilder

    let networking: Networking

    private init() {
        requestBaseURLProvider = DefaultRequestBaseURLProvider()
        metadataProvider = DefaultRequestMetadataProvider()

        requestBuilder = DefaultRequestBuilder(
            baseURLProvider: requestBaseURLProvider,
            metadataProvider: metadataProvider
        )

        networking = DefaultNetworking(requestBuilder: requestBuilder)
    }
}
