//
//  LoadingModifier.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI

/// Embeds the content in a `ZStack` allowing the display of an interaction blocking view on top of it.
private struct LoadingModifier: ViewModifier {
	
	/// `true` if the loading spinner should be visible.
	let isLoading: Bool
	
	// MARK: - ViewModifier implementation.
	
	func body(content: Content) -> some View {
		content
			.overlay {
				if isLoading {
					Color.black
						.opacity(0.15)
						.ignoresSafeArea()
						.overlay(
							ProgressView()
								.scaleEffect(3.0)
								.tint(Color(asset: Asset.Colors.mandarinJelly))
						)
				}
					
			}
			.animation(.default, value: isLoading)
	}
}

/// Using an `ObservableObject` instead of a `PreferenceKey` since sometimes the depth of the
/// view hierarchy can determine whether the loading spinner is visible or not.
final class LoadingHandler: ObservableObject {
	
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
			// Even though the `isLoading` is a value type and will not change since is a let
			// the `onChange` will be called every time the view is re-created
			// as opposed to onAppear which is called only once/ View.
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

