//
//  TabController.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation
import SwiftUI
import Combine

@Observable
class TabController {
    var tabItems: [TabItem] { TabItem.allCases }

    var selectedTab = TabItem.allCases.first! {
        willSet {
            oldSelectedTab = selectedTab
        }
    }

    private(set) var oldSelectedTab: TabItem = TabItem.allCases.first!

    let tabItemTappedSubject = PassthroughSubject<TabItem, Never>()

    @ViewBuilder
    func tabView(for tabItem: TabItem) -> some View {
        switch tabItem {
        case .deals:
            DealsTabView()
                .tabItemLabel(title: "Deals", imageName: "tag.circle")
        case .browse:
            BrowseTabView()
                .tabItemLabel(title: "Browse", imageName: "magnifyingglass.circle")
        }
    }
}
