//
//  ParallaxScroller.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI

struct ParallaxScroller: ViewModifier {
    let coordinateSpace: CoordinateSpace

    func body(content: Content) -> some View {
        content
            .opacity(0)
            .overlay {
                GeometryReader { proxy in
                    content
                        .offset(y: proxy.parallaxYTransform(relativeTo: coordinateSpace))
                }
            }
            .clipped()
    }
}

private extension GeometryProxy {
    func parallaxYTransform(relativeTo parentSpace: CoordinateSpace) -> CGFloat {
        let yGlobal = frame(in: parentSpace).origin.y

        if yGlobal > 0 {
            return 1
        } else {
            return -yGlobal / 2
        }
    }
}

struct ParallaxScroller_Previews: PreviewProvider {
    private static let spaceName: String = "Preview"

    static var previews: some View {
        ScrollView {
            VStack {
                Color.red
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1, contentMode: .fit)
                    .overlay {
                        VStack {
                            ForEach(0..<20) { _ in
                                Rectangle()
                                    .frame(height: 10)
                            }
                        }
                    }
                    .modifier(ParallaxScroller(coordinateSpace: .named(spaceName)))
                Color.black
                    .frame(width: 20, height: 1000)
            }
        }
        .coordinateSpace(name: spaceName)
    }
}
