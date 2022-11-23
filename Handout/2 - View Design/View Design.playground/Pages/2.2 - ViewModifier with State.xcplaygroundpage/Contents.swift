//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

/*:
 But there is one keyword that makes `ViewModifiers` shine: `state`. `ViewModifiers` can tap into the `Environment tree` and can hold `state`, things that you cannot do with `View extensions` because extension cannot have stored properties. This opens up the door for all sort of convenience possibilities:
 */

/// Embeds the content in a `ZStack` allowing the display of an interaction blocking view on top of it.
private struct LoadingModifier: ViewModifier {
	
	/// `true` if the loading spinner should be visible.
	let isLoading: Bool
	
	// MARK: - ViewModifier implementation.
	
	func body(content: Content) -> some View {
		ZStack {
			content
				// Set the layout priority so that the size of the ZStack will not be influenced by the loading overlay.
				.layoutPriority(1)
				// Assign explicit index since we're adding the loading spinner and blocking view
				// animated when isLoading == true and without the index sometimes the animation doesn't happen.
				.zIndex(0)
			
			if isLoading {
				Color.red
					.opacity(0.1)
					.ignoresSafeArea()
					.overlay(
						ProgressView()
					)
					.zIndex(1)
			}
		}
		.animation(.default, value: isLoading)
	}
}

/// Using an `ObservableObject` instead of a `PreferenceKey` since sometimes the depth of the
/// view hierarchy can determine whether the loading spinner is visible or not.
private final class LoadingHandler: ObservableObject {
	
	/// `true` will determine the loading spinner to be displayed.
	@Published var isLoading: Bool = false
}

/// Allows the propagation and control of the loading spinner display state through the
/// `SwiftUI` view hierarchy.
private struct HierarchyLoadingSpinnerModifier: ViewModifier {
	
	/// Intermediates the setter propagation logic and the `LoadingModifier` needs.
	@StateObject private var loadingHandler: LoadingHandler = .init()
	
	// MARK: - ViewModifier implementation.
	
	func body(content: Content) -> some View {
		content
			.modifier(LoadingModifier(isLoading: loadingHandler.isLoading))
			.environmentObject(loadingHandler)
	}
}

/// Extracts the `LoadingHandler` from the environment and modifies the value based
/// on the one passed in as parameter.
private struct IsLoadingModifier: ViewModifier {
	
	/// `true` if the loading spinner should be visible or not.
	let isLoading: Binding<Bool>
	
	/// Intermediates the setter propagation logic and the `LoadingModifier` needs.
	@EnvironmentObject private var loadingHandler: LoadingHandler
	
	// MARK: - ViewModifier
	
	func body(content: Content) -> some View {
		content
			.onChange(of: isLoading.wrappedValue) { loadingHandler.isLoading = $0 }
	}
}

extension View {
	
	/// Displays a screen blocking loading spinner that can be controlled by child views
	/// using the `View.isLoading(_:)` method.
	func withHierarchyLoadingSpinner() -> some View {
		modifier(
			HierarchyLoadingSpinnerModifier()
		)
	}
	
	/// Represents the counterpart and controlling method of the `withHierarchyLoadingSpinner` and determines whether the `LoadingSpinner`
	/// controlled by that method is shown or not. Any previous values will be overwritten.
	/// - Parameter isLoading: `true` if the spinner should be visible.
	func isLoading(_ isLoading: Binding<Bool>) -> some View {
		modifier(
			IsLoadingModifier(isLoading: isLoading)
		)
	}
}

/*:
 Here we declare a `ViewModifier` that adds a loading spinner on top of the `whole` content and whose appearance we can modify though an infrastructure that is opaque to the user: `IsLoadingModifier` publishes values that `HierarchyLoadingSpinnerModifier` reacts to through `LoadingHandler`.
 */

struct RootView: View {
	
	@State private var isLoading: Bool = false
	
	var body: some View {
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
			.isLoading($isLoading)
			.withHierarchyLoadingSpinner()
	}
}

PlaygroundPage.current.setLiveView(RootView().frame(width: 300.0))

//: [Next](@next)
