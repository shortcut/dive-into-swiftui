//: [Previous](@previous)

/*: # Custom Alignment

 Taking a peek at what `HorizontalAlignment` and `VerticalAlignment` can be initialized with we get a glimpse of the fact that we can create our of alignments through `AlignmentID` protocol.
 
 ```swift
 @frozen public struct HorizontalAlignment {
 
	public init(_ id: AlignmentID.Type)
 }
 
 @frozen public struct VerticalAlignment {
 
	public init(_ id: AlignmentID.Type)
 }
 ```
 and
 ```
 public protocol AlignmentID {
	 
	 /// - Parameter context: The context of the view that you apply
	 ///   the alignment guide to. The context gives you the view's dimensions,
	 ///   as well as the values of other alignment guides that apply to the
	 ///   view, including both built-in and custom guides. You can use any of
	 ///   these values, if helpful, to calculate the value for your custom
	 ///   guide.
	 ///
	 /// - Returns: The offset of the guide from the origin in the
	 ///   view's coordinate space.
	 static func defaultValue(in context: ViewDimensions) -> CGFloat
 }
 ```
 
 But what could you use a custom alignment at? What purpose could it serve that the default ones do not do that already?
 Imagine the `VStack`, when you provide `.leading` alignment, _all_ the `Views` align to the leading edge. But what if you wanted to align just 2 `Views`, not all of them?
 
 Let's take a look at the following scenario:
 
 ![avatar](avatar-alignment.png)
 
 As we can see, the avatar aligns differently based on the different chat bubble contents. If the avatar were to always align on top with the content, that would be easy: a `ViewModifier` that adds the avatar in an `HStack` together with the content and aligns them to `.top`.
 The obvious choice is to embed the avatar into each bubble. But doing this would:
 - break reusability of the chat bubble;
 - include extra code to handle adding the avatar in each chat bubble;
 - while for some it will be straightforward, for some contexts aligning the avatar with one of the components of the `View` will increase the overall complexity of the alignment;
 
 Let's try with a custom alignment:
 */

import SwiftUI
import PlaygroundSupport

extension VerticalAlignment {
	private enum MessageContentAlignment: AlignmentID {
		static func defaultValue(in d: ViewDimensions) -> CGFloat {
			d[.top]
		}
	}
	
	/// Defines an alignment used to coordinate multiple views which might not be found in the same `parent` in a custom way.
	/// This one is used in the `ChatBubbleAvatarModifier` to allow the alignment with the replied message as opposed to any
	/// other components that are added on top.
	static let messageContentAlignment = VerticalAlignment(MessageContentAlignment.self)
}

/// Adds the visual representation of the user as an `avatar`, leading to the current content.
private struct ChatBubbleAvatarModifier: ViewModifier {
	
		// MARK: - ViewModifier implementation.
	
	func body(content: Content) -> some View {
		HStack(alignment: .messageContentAlignment, spacing: .zero) {
			AvatarImage()
				.frame(width: 25.0, height: 25.0)
				.padding(.trailing, 13.0)
				.alignmentGuide(.messageContentAlignment) { $0[.top] }
			
			content
		}
	}
}

extension View {
	
	/// Adds the visual representation of the user as an `avatar`, leading to the current content and
	/// aligned with `VerticalAlignment.messageContentAlignment`.
	func withAvatar() -> some View {
		modifier(
			ChatBubbleAvatarModifier()
		)
	}
}

struct ContentTextChatBubble: View {
	
	var body: some View {
		VStack(alignment: .leading, spacing: -5.0) {
			Color.red
				.frame(width: 150.0, height: 80.0)
				.cornerRadius(5.0)
			TextChatBubble(text: "Awesome 😀 Can’t wait!")
				.alignmentGuide(.messageContentAlignment, computeValue: { $0[.top] })
		}
	}
}

struct ContentView: View {
	
	var body: some View {
		VStack(alignment: .leading) {
			TextChatBubble()
				.withAvatar()
			ContentTextChatBubble()
				.withAvatar()
			
			VStack(alignment: .leading, spacing: 2.0) {
				Text("Eva's maze message")
					.foregroundColor(.gray)
					.font(.footnote)
				ContentTextChatBubble()
			}
			.withAvatar()
		}
	}
}

PlaygroundPage.current.setLiveView(
	ContentView()
		.frame(width: 400.0)
		.padding()
)

/*:
 Going step by step on the implementation:
 
 1. declare your custom `Alignment`; `lines 54-65`;
 2. use it in a container so that the child Views/ subviews will inherit it; `line 73`;
 3. whenever you want to align a `View` with the custom `Alignment` make sure to specifically declare the alignment guide for that value and provide an anchor point to which the `Alignment` should refer to when aligning the two `Views`; `line 103`;
 
 Try playing with multiple values on line `103` and see what happens. Also, try removing it. It almost feels like dark magic, doesn't it?!
 */

//: [Next](@next)
