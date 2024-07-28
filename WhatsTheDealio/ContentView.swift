//
//  ContentView.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/27/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(TabController.self) private var tabController
    
    var body: some View {
        TabView(
            selection: Binding {
                tabController.selectedTab
            } set: { newValue in
                tabController.selectedTab = newValue
                tabController.tabItemTappedSubject.send(newValue)
            }
        ) {
            ForEach(tabController.tabItems) {
                tabController.tabView(for: $0)
                    .tag($0)
            }
        }
    }
}

#Preview {
    ContentView()
}
