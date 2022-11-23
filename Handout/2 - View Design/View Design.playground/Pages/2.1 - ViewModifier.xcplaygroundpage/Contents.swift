//: [Previous](@previous)

/*: # ViewModifier
 
 A `view modifier` is generically referred to as anything that you apply to a `View` that modifies its appearance `.font(_:)`, `.background(_:)`, `.foregroundColor(_:)`, `.frame()` are all view modifiers. `ViewModifiers` is another tool in our box that we have in order to make the code as modular and reusable as possible. As advertised and encouraged by all the APIs from `SwiftUI` we should think of the UI as multiple, smaller, lightweight components put together as opposed to big generic "screen" components.
 
 And `SwiftUI` has given the developers the power to create any custom `view modifier` that they want through the adoption of the `ViewModifier` protocol. It works together with `.modifier(_:)` and provides a reusable way of customizing the appearance of your `Views`.
 `ViewModifier` it has only one protocol requirement: `func body(content:) -> some View`. The `content` is the `View` tree on which the `.modifier(_:)` method has been called. This makes a huge impact and we need to be careful at the _order_ in which we apply `ViewModifiers` on `Views` because that in some cases it matters!
 */

import SwiftUI
import PlaygroundSupport

struct TerminalSectionViewModifier: ViewModifier {
		
	func body(content: Content) -> some View {
		VStack(alignment: .leading, spacing: 15.0) {
			HStack {
				Image(systemName: "terminal.fill")
				Text("try it yourself!")
					.frame(maxWidth: .infinity, alignment: .leading)
				Image(systemName: "play.fill")
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			content
				.font(.system(size: 15.0, weight: .light).italic())
		}
		.padding()
		.background(Color.gray)
		.clipShape(RoundedRectangle(cornerRadius: 12.0))
	}
}

extension View {
	
	func runInTerminalSection() -> some View {
		modifier(TerminalSectionViewModifier())
	}
}

PlaygroundPage.current.setLiveView(Text("echo \"Hello World!\"").runInTerminalSection().frame(width: 300.0))

/*:
 At this point you might be thinking, "wait, I can do that in the `View.runInTerminalSection() -> some View` as well.
 Let's see how that would look:
 */

extension View {
	
	func runInTerminalSection_all() -> some View {
		VStack(alignment: .leading, spacing: 15.0) {
			HStack {
				Image(systemName: "terminal.fill")
				Text("try it yourself!")
					.frame(maxWidth: .infinity, alignment: .leading)
				Image(systemName: "play.fill")
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			self
				.font(.system(size: 15.0, weight: .light).italic())
		}
		.padding()
		.background(Color.gray)
		.clipShape(RoundedRectangle(cornerRadius: 12.0))
	}
}

PlaygroundPage.current.setLiveView(Text("echo \"Hello World!\"").runInTerminalSection().frame(width: 300.0))

/*:
 You are totally right, it works and looks the same! `View extensions` are great for **stateless** customisation of appearance since you get the same reusability benefits without any change of API: in both situations we're using the `View` extension method instead of explicitly calling: `.modifier(_:)`.
 */

//: [Next](@next)
