//
//  View+ScrollViewHeader.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI

extension View {
    func scrollViewHeader(effects: ScrollViewHeaderModifier.Effect, coordinateSpace: CoordinateSpace) -> some View {
        self.modifier(ScrollViewHeaderModifier(effects: effects, coordinateSpace: coordinateSpace))
    }
}

struct ScrollViewHeaderModifier: ViewModifier {
    struct Effect: OptionSet {
        static let grow = Effect(rawValue: 0 << 1)
        static let parallax = Effect(rawValue: 0 << 2)

        var rawValue: Int
    }

    let effects: Effect
    let coordinateSpace: CoordinateSpace

    func body(content: Content) -> some View {
        switch effects {
        case [.grow, .parallax]:
            content
                .modifier(ParallaxScroller(coordinateSpace: coordinateSpace))
                .modifier(ExpandingScroller(coordinateSpace: coordinateSpace))
        case .grow:
            content
                .modifier(ExpandingScroller(coordinateSpace: coordinateSpace))
        case .parallax:
            content
                .modifier(ParallaxScroller(coordinateSpace: coordinateSpace))
        default:
            content
        }
    }
}
