//
//  TrackingScroller.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI

// MARK: - Size.

private struct OffsetPreferenceKey: PreferenceKey {
	static var defaultValue: CGPoint = .zero
	static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}

extension View {
	
	/// Tracks the origin of a `View` in a given `CoordinateSpace` and reports back with every change.
	/// - Parameters:
	///   - parentSpace: Defines the relative place to which the origin is computed.
	///   - onOffsetChange: Acts like a scrollOffset callback.
	func readOffsetChanges(in parentSpace: CoordinateSpace, onOffsetChange: @escaping (CGPoint) -> Void) -> some View {
		background(
			GeometryReader { proxy in
				Color.clear
					.preference(key: OffsetPreferenceKey.self, value: proxy.frame(in: parentSpace).origin)
			}
		)
		.onPreferenceChange(OffsetPreferenceKey.self, perform: onOffsetChange)
	}
}
