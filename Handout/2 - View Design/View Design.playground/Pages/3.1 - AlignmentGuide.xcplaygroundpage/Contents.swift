//: [Previous](@previous)

/*: AlignmentGuide
 
 Remember `NSLayoutAnchor`? `AlignmentGuide` is his distant modern, lightweight uncle.
 
 _"An alignment guide is basically a numeric value. It sets a point in a view, that determines how to position it in relation to the rest of its siblings"_ as Javier has nicely put it in: https://swiftui-lab.com/alignment-guides/
 
 You have probably interacted with alignments before. Each `stack` View type has an alignment parameter. Overlay has been recently enhanced with it. `.frame()` modifier has an alignment as well. You're most likely familiar with it and its effects: it moves `Views` to different sides of the `container View` or within the `container View` based on its value.
 
 ⚠️ As counterintuitive as it might sound, `VerticalStacks` use `HorizontalAlignment` and `HorizontalStacks` use `VerticalAlignment`. And it makes sense once you think about it. You cannot align the elements on the vertical axis in a `VerticalStack`, they are one under the other by default and it's expected, but you can align them to the leading or trailing edges.
 
 But what does `AlignmentGuide` APIs do then? Well, they give you the chance to have a say in _how_ and _if_ certain Views respect the alignment. It's important to understand that every `View`, when embedded in a `container View` it is assigned an `AlignmentGuide` that the container controls.
 The way that we can interact with the `AlignmentGuide` of a `View` is though the `View.alignmentGuide(_:computeValue:)` API.
 ‼️ one important consideration is that the alignment value (on an axis) you provide to the API needs to be alignment value that the container uses on the same axis.
 e.g. if you use `.alignmentGuide(.leading, computeValue: { _ in 20 })` and the container uses `.trailing` alignment, the `.alignmentGuide` will have no effect. There needs to be a match.
 */

import SwiftUI
import PlaygroundSupport

struct AlignmentExample: View {
	
	private let horizontalValues: [HorizontalAlignment] = [.leading, .center, .trailing]
	private let verticalValues: [VerticalAlignment] = [.top, .center, .bottom]
	
	@State private var horizontal: HorizontalAlignment = .center
	@State private var vertical: VerticalAlignment = .center
	
	var body: some View {
		HStack {
			verticalColumn
			VStack {
				example
				horizontalRow
			}
		}
		.animation(.default, value: horizontal)
		.animation(.default, value: vertical)
	}
	
	private var horizontalRow: some View {
		HStack {
			ForEach(horizontalValues) { alignment in
				Button(alignment.stringValue, action: { horizontal = alignment })
			}
		}
	}
	
	private var verticalColumn: some View {
		VStack {
			ForEach(verticalValues) { alignment in
				Button(alignment.stringValue, action: { vertical = alignment })
			}
		}
	}
	
	private var example: some View {
		ZStack(alignment: Alignment(horizontal: horizontal, vertical: vertical)) {
			Color.red
				.frame(width: 100.0, height: 100.0)
			Color.yellow
				.frame(width: 20.0, height: 20.0)
		}
	}
}

PlaygroundPage.current.setLiveView(AlignmentExample())

//: [Next](@next)
