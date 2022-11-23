//
//  ExpandingScroller.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI

struct ExpandingScroller: ViewModifier {
    let coordinateSpace: CoordinateSpace

    func body(content: Content) -> some View {
        content
            .opacity(0)
            .overlay {
                GeometryReader { proxy in
                    content
                        .scaleEffect(x: proxy.offsetScale(relativeTo: coordinateSpace),
                                     y: proxy.offsetScale(relativeTo: coordinateSpace))
                        .offset(y: proxy.offsetYTransform(relativeTo: coordinateSpace))
                }
            }
    }
}

private extension GeometryProxy {
    func offsetScale(relativeTo parentSpace: CoordinateSpace) -> CGFloat {
        let yGlobal = frame(in: parentSpace).origin.y

        if yGlobal > 0 {
            return 1 + (yGlobal / size.width)
        } else {
            return 1
        }
    }

    func offsetYTransform(relativeTo parentSpace: CoordinateSpace) -> CGFloat {
        let yGlobal = frame(in: parentSpace).origin.y

        if yGlobal > 0 {
            return -yGlobal / 2
        } else {
            return 1
        }
    }
}

struct ExpandingScroller_Previews: PreviewProvider {
    private static let spaceName: String = "Preview"

    static var previews: some View {
        ScrollView {
            VStack {
                Color.red
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1, contentMode: .fit)
                    .modifier(ExpandingScroller(coordinateSpace: .named(spaceName)))
                Color.black
                    .frame(width: 20, height: 1000)
            }
        }
        .coordinateSpace(name: spaceName)
    }
}
