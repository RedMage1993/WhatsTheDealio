//
//  TabItemLabel.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation
import SwiftUI

struct TabItemLabel: ViewModifier {
    let title: String
    let imageName: String

    func body(content: Content) -> some View {
        content
            .tabItem {
                Label(title, systemImage: imageName)
            }
    }
}

extension View {
    func tabItemLabel(title: String, imageName: String) -> some View {
        modifier(TabItemLabel(title: title, imageName: imageName))
    }
}
