//
//  Boostrap.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation
import SwiftUI

struct Bootstrap: ViewModifier {
    func body(content: Self.Content) -> some View {
        content
    }
}

extension View {
    func bootstrap() -> some View {
        modifier(Bootstrap())
    }
}
