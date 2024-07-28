//
//  DealsTabView.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation
import SwiftUI

struct DealsTabView: View {
    var body: some View {
        TabNavigationStackView(tab: .deals) {
            Text("Deals")
        }
    }
}
