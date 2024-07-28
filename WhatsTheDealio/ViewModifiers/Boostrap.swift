//
//  Boostrap.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation
import SwiftUI

struct Bootstrap: ViewModifier {
    @State private var tabController = TabController()
    @State private var deeplinkManager = DeeplinkManager(
        appScheme: "dealio",
        hostName: "fritzammon.com",
        regexMatchers: [DealDetailDeeplinkRegexMatcher()]
    )
    
    func body(content: Self.Content) -> some View {
        content
            .environment(tabController)
            .environment(deeplinkManager)
            .onOpenURL(perform: openURL)
    }
    
    func openURL(_ url: URL) {
        Task {
            try await deeplinkManager.parseURL(url)
        }
    }
}

extension View {
    func bootstrap() -> some View {
        modifier(Bootstrap())
    }
}
