//: [Previous](@previous)

/*:
 As hinted in the previous sections, the order in which we apply `ViewModifiers` matters.
 Let's analyse the previous piece of code. Didn't it look strange to you too?!
*/

struct RootView: View {
	
	@State private var isLoading: Bool = false
	
	var body: some View {
		textContent
			.isLoading($isLoading) // ⁉️
			.withHierarchyLoadingSpinner() // ⁉️
	}
	
	// extracted non-modified content for better readability.
	private var textContent: some View {
		Text("curl www.apple.com")
			.tint(Color.red)
			.runInTerminalSection()
			.onTapGesture {
				Task { @MainActor in
					isLoading = true
					// Simulate curl time.
					try? await Task.sleep(for: .seconds(2.0))
					isLoading = false
				}
			}
	}
}

/*:
 ⁉️ We're declaring the hierarchy loading spinner _after_ declaring that we want to display the loading spinner? How does that even make sense?
 ✅ Before diving into the reason, try switching the order and see what runtime error you get.
 
 Going back to the first section and the `ViewModifier.body(content:)` protocol method, let's try to roughly expand the `View tree` and see why this "unnatural" order is working and the other way around is not.
 */

import SwiftUI
import PlaygroundSupport

struct RedModifier: ViewModifier {
	
	func body(content: Content) -> some View {
		content
			.background(Color.red)
	}
}

struct ModifierHierarchyView: View {
	
	var body: some View {
		VStack {
			Text("Testing ViewModifier tree")
				.printType(example: ".modifier(_:)")
			Text("Testing ViewModifier tree")
				.modifier(RedModifier())
				.printType(example: ".modifier(_:)")
		}
	}
}

extension View {
	
	/// Print through an extension method so that `self` can be even small components of a `View`.
	func printType(example: String = "") -> some View {
		onAppear { print("\(example): View type: \(self)") }
	}
}

print("\n\n === ModifierHierarchyView === \n\n")
PlaygroundPage.current.setLiveView(ModifierHierarchyView())

/*:
 Running the above code will result int the following output
 
 ```bash
 Type: ModifiedContent<Text, RedModifier>(content: SwiftUI.Text(storage: SwiftUI.Text.Storage.anyTextStorage(<LocalizedTextStorage: 0x0000600002f14550>: "Test"), modifiers: []), modifier: __lldb_expr_73.RedModifier())
 Type: Text(storage: SwiftUI.Text.Storage.anyTextStorage(<LocalizedTextStorage: 0x0000600002f3c280>: "Test"), modifiers: [])
 ```

 The `View` resulted from the code that sits above the `.modifier(_:)` is "wrapped around" in a `ModifiedContent`. Transforming the same code _without_ using `.modifier(_:)` would look like:
 */

struct ModifierHierarchyView_Expanded: View {
	
	var body: some View {
		VStack {
			Text("Testing ViewModifier tree")
				.printType(example: "ModifiedContent")
			ModifiedContent(
				content: Text("Testing ViewModifier tree"),
				modifier: RedModifier()
			)
			.printType(example: "ModifiedContent")
		}
	}
}

print("\n\n === ModifierHierarchyView_Expanded === \n\n")
PlaygroundPage.current.setLiveView(ModifierHierarchyView_Expanded())

/*:
 Running this playground again will result in equivalent types. But what we want to showcase with this explicit declaration is the fact that `ViewModifiers` should be read in a `FILO order`.
 
 In other words...
 - The "later" in your declaration you apply them, the faster it will take precedence in execution; First modifier In, Last modifier Out.
 - The `View` resulted from the code that sits above the `.modifier(_:)` becomes the "child View"/ "subview" of the `ModifiedContent`;
 
 Going back to our example, the expanded equivalent code would be:
 */

struct RootView_Expanded: View {
	
	@State private var isLoading: Bool = false
	
	var body: some View {
		ModifiedContent(
			content: ModifiedContent(
				content: textContent,
				modifier: IsLoadingModifier(isLoading: $isLoading)
			),
			modifier: HierarchyLoadingSpinnerModifier()
		)
	}
	
	private var textContent: some View {
		Text("curl www.apple.com")
			.tint(Color.red)
			.runInTerminalSection()
			.onTapGesture {
				Task { @MainActor in
					isLoading = true
					// Simulate curl time.
					try? await Task.sleep(for: .seconds(2.0))
					isLoading = false
				}
			}
	}
}

/*:
 If you ran the first example by switching the order of the modifiers, you would see that the program crashes because: `LoadingHandler` could not be found as part of the `View tree hierarchy`. This happens because `IsLoadingModifier` references `LoadingHandler` through `@EnvironmentObject`. `@EnvironmentObject` requires the dependency be injected through the `Environment` by a "superview".
 
 By first applying `HierarchyLoadingSpinnerModifier` and then `IsLoadingModifier`, the `View` using `IsLoadingModifier` would be the superview of the `View` using `HierarchyLoadingSpinnerModifier` and hence the mystery is unveiled.
 
 Whenever using `ViewModifiers` be mindful of the order in which you apply them. 
 */

//: [Next](@next)
