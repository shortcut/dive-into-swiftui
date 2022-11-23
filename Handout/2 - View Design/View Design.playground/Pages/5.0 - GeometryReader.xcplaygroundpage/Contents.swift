//: [Previous](@previous)

/*: GeometryReader
 
 This `component` allows you to `read` the realtime value of the `size` of the `content` and the `frame` in which it's being rendered and not only. Sometimes there is no way around to placing/ sizing `Views` other than doing some maths based on the size of the container.
 
 It was notoriously inefficient but there is no other way to tap into the coordinate/ size system of `Views`. Following the sizing rules in `SwiftUI` in which the parent `View` asks his child views/ subviews for a preferred size, the `GeometryReader` will take **all the size it has**. Just like `Color`. So, be careful when using it and be mindful that this can happen. You might find `.fixedSize(horizontal:vertical:)` to be of good use in some situations.
 */

import SwiftUI
import PlaygroundSupport

/// Fits as many names as possible in the given space.
struct NamesFitView: View {
	
	/// Data source.
	let items: [String]
	
	// MARK: - Private state.
	
	/// The number of items that fit in the available space.
	/// Required to compute the placeholder.
	@State private var fittedItemsCount: Int = .max
	
	/// Mapping between the rendered data and their width.
	@State private var itemsWidth: [String: CGFloat] = [:]
	
	/// Total width of the `Placeholder` view.
	@State private var remainingItemsHintWidth: CGFloat = 0.0
	
	// MARK: - Body.
	
	var body: some View {
		GeometryReader { proxy in
			HStack(spacing: .zero) {
				// Use zip instead of .enumerated(): https://stackoverflow.com/a/63145650
				ForEach(Array(zip(items.indices, items)).prefix(fittedItemsCount), id: \.0) { index, item in
					HStack(spacing: .zero) {
						Text(item)
							.fixedSize()
						// Don't display the separator for the last item.
						if index < fittedItemsCount - 1 {
							Text(", ")
								.fixedSize()
						}
					}
						.padding(.trailing, 5.0)
						// Fix the size on vertical since we don't want the View to increase in height in order to fit.
						.fixedSize(horizontal: false, vertical: true)
						.readSize { itemsWidth[item] = $0.width }
				}
				
				// After we've rendered all the available fitted
				(
					Text(items.count - fittedItemsCount > 0 ? "+\(items.count - fittedItemsCount) " : "") +
					Text("others liked your code")
				)
						// Fix the size on vertical since we don't want the View to increase in height in order to fit.
						.fixedSize()
						.readSize { remainingItemsHintWidth = $0.width }
			}
				.onChange(of: itemsWidth) { _ in computeItems(proxy: proxy) }
		}
	}
	
	// MARK: - Private interface.
	
	/// Determines `how many elements we can fit in the available space`.
	/// - Parameter proxy: Should reflect the `available space` of the container in which we want to fit the `Cells`.
	private func computeItems(proxy: GeometryProxy) {
		// For one item, make sure to not perform the fitting logic since that would be pointless.
		guard items.count >= 2, !itemsWidth.isEmpty else {
			fittedItemsCount = items.count
			return
		}
	
		let availableWidth = proxy.size.width - remainingItemsHintWidth
		var currentSize: CGFloat = 0
		var currentlyRenderedItems = 0
		for item in items {
			guard let itemWidth = itemsWidth[item] else {
				return assertionFailure("We did not get to render this item. Failure.")
			}
			
			guard currentSize + itemWidth < availableWidth else { break }
			currentSize += itemWidth
			currentlyRenderedItems += 1
		}
		fittedItemsCount = currentlyRenderedItems
	}
}

struct ContentView: View {
	
	var body: some View {
		HStack {
			Image(systemName: "heart.fill")
				.foregroundColor(.red)
			NamesFitView(items: ["Michael", "Fabi", "Lavinia", "Joachim", "Sakshi"])
		}
		.padding()
		.background(Color.yellow)
		.frame(width: 400.0)
	}
}

PlaygroundPage.current.setLiveView(ContentView())

//: [Next](@next)
