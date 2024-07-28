//
//  TabNavigationDestinationViewFactory.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation
import SwiftUI

struct TabNavigationDestinationViewFactory: NavigationDestinationViewFactory {
    func view(for destination: TabNavigationDestination) -> some View {
        switch destination {
        case .detail(let id):
            Text("Deal Detail for \(id)")
        }
    }
}
