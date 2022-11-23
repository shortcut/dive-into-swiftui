import SwiftUI

public extension View {
		
	///  Inspired and borrowed from:
	///		- https://fivestars.blog/swiftui/flexible-swiftui.html
	///		- https://maxr.dev/blog/flow-grid-in-swiftui
	/// This needs to be aware of the scale factor, since this will be called AFTER the scale modification has been applied,
	/// and it will loop into itself and give us a wrong measurement. Once we know the scale factor, it needs to be accounted for, so
	/// that the `.frame()` modifier used for scaling up the rows actually has effect
	func readSize(_ scaleFactor: CGFloat = 1, onChange: @escaping (CGSize) -> Void) -> some View {
		background(
			GeometryReader { geometryProxy in
				Color.clear
					.preference(key: SizePreferenceKey.self, value: CGSize(width: geometryProxy.size.width / scaleFactor, height: geometryProxy.size.height / scaleFactor))
			}
		)
		.onPreferenceChange(SizePreferenceKey.self, perform: onChange)
	}
}

// MARK: - Size.

private struct SizePreferenceKey: PreferenceKey {
	static var defaultValue: CGSize = .zero
	static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
