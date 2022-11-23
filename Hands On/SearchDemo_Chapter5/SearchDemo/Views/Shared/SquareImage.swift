//
//  SquareImage.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI

struct SquareImage: View {
    let image: Image

    var body: some View {
        Color.clear
            .overlay {
                image
                    .resizable()
                    .scaledToFill()
            }
            .aspectRatio(1, contentMode: .fill)
            .clipped()
            .overlay {
                Color.black.opacity(0.75)
            }
            .overlay {
                image
                    .resizable()
                    .scaledToFit()
            }
            .aspectRatio(1, contentMode: .fit)
    }
}

struct SquareImage_Previews: PreviewProvider {
    static var previews: some View {
        SquareImage(image: Image("Aspect/tall"))
            .previewLayout(.fixed(width: 300, height: 300))
            .previewDisplayName("Tall")

        SquareImage(image: Image("Aspect/square"))
            .previewLayout(.fixed(width: 300, height: 300))
            .previewDisplayName("Square")

        SquareImage(image: Image("Aspect/wide"))
            .previewLayout(.fixed(width: 300, height: 300))
            .previewDisplayName("Wide")
    }
}
