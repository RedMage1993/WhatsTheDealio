//
//  NavigationCoordinator.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation
import SwiftUI

@Observable
class NavigationCoordinator<T: NavigationDestinationViewFactory> {
    let navigationDestinationViewFactory: T

    var path = NavigationPath()

    init(navigationDestinationViewFactory: T) {
        self.navigationDestinationViewFactory = navigationDestinationViewFactory
    }

    func push(_ destination: T.Destination) {
        path.append(destination)
    }
}
