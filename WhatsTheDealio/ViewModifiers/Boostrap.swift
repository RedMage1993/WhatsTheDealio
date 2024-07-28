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
    
    func body(content: Self.Content) -> some View {
        content
            .environment(tabController)
    }
}

extension View {
    func bootstrap() -> some View {
        modifier(Bootstrap())
    }
}
