//: [Previous](@previous)

/*:
 Let's modify some `AlignmentGuide` values and explore the API a bit:
 
 - remove `hDimensions` and `vDimensions` and see the change;
 - play with different values of `hDimensions` and `vDimensions`;
 - move the alignmentGuide APIs from the PS logo to the Text and observe the change;
 - play with different values and insert different values and observe the change;
 */

import SwiftUI
import PlaygroundSupport

struct BadgeAlignment: View {
	
	// MARK: - Horizontal.
	
	private let horizontalValues: [HorizontalAlignment] = [.leading, .center, .trailing]
	@State private var horizontal: HorizontalAlignment = .center
	@State private var customHorizontalValue: String = ""
	
	var customHorizontalCGFloatValue: CGFloat {
		Double(customHorizontalValue) ?? .zero
	}
	
	// MARK: - Vertical
	
	private let verticalValues: [VerticalAlignment] = [.top, .center, .bottom]
	@State private var vertical: VerticalAlignment = .center
	@State private var customVerticalValue: String = ""
	
	var customVerticalCGFloatValue: CGFloat {
		Double(customVerticalValue) ?? .zero
	}
	
	// MARK: - Body.
	
	var body: some View {
		VStack {
			HStack {
				VStack {
					Picker("Horizontal", selection: $horizontal) {
						ForEach(horizontalValues) { alignment in
							Text(alignment.stringValue)
								.tag(alignment)
						}
					}
					Picker("Vertical", selection: $vertical) {
						ForEach(verticalValues) { alignment in
							Text(alignment.stringValue)
								.tag(alignment)
						}
					}
				}
				example
			}
			HStack {
				Text("Horizontal value:")
				TextField.init("insert value", text: $customHorizontalValue)
			}
			HStack {
				Text("Vertical value:")
				TextField.init("insert value", text: $customVerticalValue)
			}
		}
		.animation(.default, value: horizontal)
		.animation(.default, value: vertical)
	}
	
	private var example: some View {
		ZStack(alignment: Alignment(horizontal: horizontal, vertical: vertical)) {
			Color.yellow
				.overlay(
					Image(systemName: "playstation.logo")
						.resizable()
						.scaledToFit()
						.frame(width: 100.0, height: 100.0)
				)
				.frame(width: 200.0, height: 200.0)
				// 👇🏻 Move alignment guide here and observe the changes.
				.alignmentGuide(horizontal, computeValue: { hDimensions in
					hDimensions[horizontal] + customHorizontalCGFloatValue })
				.alignmentGuide(vertical, computeValue: { vDimensions in vDimensions[vertical] + customVerticalCGFloatValue })
			Text("God of War")
				.font(.footnote)
				.padding(5.0)
				.background(Color.red)
				.cornerRadius(9.0)
				// 👇🏻 Move alignment guide here and observe the changes.
		}
		// Follow the background to observe frame changes based on alignment.
		.background(Color.gray)
	}
}

PlaygroundPage.current.setLiveView(
	BadgeAlignment()
		.padding()
		.frame(width: 500.0)
)

//: [Next](@next)
