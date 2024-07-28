//
//  Font+Extensions.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation
import SwiftUI

enum CustomFont {
    case outfit(Weight)
    case inter(Weight)

    var name: String {
        switch self {
        case .outfit(let weight):
            "Outfit-\(weight.rawValue)"
        case .inter(let weight):
            "Inter-\(weight.rawValue)"
        }
    }

    enum Weight: String {
        case bold = "Bold"
        case black = "Black"
        case thin = "Thin"
        case semibold = "SemiBold"
        case extraLight = "ExtraLight"
        case regular = "Regular"
        case extraBold = "ExtraBold"
        case medium = "Medium"
        case light = "Light"
    }
}

extension Font {
    static func custom(_ font: CustomFont, size: CGFloat) -> Font {
        .custom(font.name, size: size)
    }
}
