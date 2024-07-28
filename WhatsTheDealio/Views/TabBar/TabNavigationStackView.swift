//
//  TabNavigationStackView.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation
import SwiftUI

struct TabNavigationStackView<Root: View>: View {
    let tab: TabItem
    let content: Root

    @State private var tabNavigationCoordinator = NavigationCoordinator(navigationDestinationViewFactory: TabNavigationDestinationViewFactory())
    @State private var listController = ListController()
    @Environment(DeeplinkManager.self) private var deeplinkManager
    @Environment(TabController.self) private var tabController

    init(tab: TabItem, content: () -> Root) {
        self.tab = tab
        self.content = content()
    }

    var body: some View {
        NavigationStack(path: $tabNavigationCoordinator.path) {
            content
            // TODO: - Remove this when pop to root NavigationBar UI glitch is fixed by Apple
                .toolbar(.automatic, for: .navigationBar)
                .navigationDestination(for: TabNavigationDestination.self, destination: tabNavigationCoordinator.navigationDestinationViewFactory.view)
        }
        .onReceive(tabController.tabItemTappedSubject) { tabItem in
            guard tabItem == tabController.oldSelectedTab,
                  tabItem == tab
            else { return }

            if tabNavigationCoordinator.path.count == 0 {
                listController.scrollToTopSubject.send()
            } else {
                tabNavigationCoordinator.path.removeLast(tabNavigationCoordinator.path.count)
            }
        }
        .environment(tabNavigationCoordinator)
        .environment(listController)
        .onChange(of: deeplinkManager.deeplink) {
            Task { @MainActor in
                guard tabController.selectedTab == tab else { return }

                await deeplinkManager.consumeDeeplink {
                    switch $0 {
                    case .dealDetail(let id):
                        tabNavigationCoordinator.push(.dealDetail(id))
                    }

                    return true
                }
            }
        }
    }
}
