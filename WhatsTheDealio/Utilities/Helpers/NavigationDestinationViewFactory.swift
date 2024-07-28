//
//  NavigationDestinationViewFactory.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation
import SwiftUI

protocol NavigationDestinationViewFactory {
    associatedtype Destination: Hashable
    associatedtype DestinationView: View

    @ViewBuilder
    func view(for destination: Destination) -> DestinationView
}
