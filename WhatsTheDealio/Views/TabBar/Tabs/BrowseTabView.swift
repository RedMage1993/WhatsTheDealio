//
//  BrowseTabView.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation
import SwiftUI

struct BrowseTabView: View {
    var body: some View {
        TabNavigationStackView(tab: .browse) {
            Text("Browse")
        }
    }
}
