//
//  CachedAsyncImage.swift
//  WhatsTheDealio
//
//  Created by Fritz Ammon on 7/28/24.
//

import Foundation
import SwiftUI

struct CachedAsyncImage<Content: View, Placeholder: View>: View {
    let url: URL?
    let content: (Image) -> Content
    let placeholder: Placeholder

    @State private var image: UIImage?

    init(url: URL?, @ViewBuilder content: @escaping (Image) -> Content, @ViewBuilder placeholder: () -> Placeholder) {
        self.url = url
        self.content = content
        self.placeholder = placeholder()
    }

    var body: some View {
        if let image {
            content(Image(uiImage: image))
        } else {
            placeholder
                .task {
                    guard let url,
                          let (data, _) = try? await URLSession.shared.data(from: url)
                    else { return }

                    image = UIImage(data: data)
                }
        }
    }
}
