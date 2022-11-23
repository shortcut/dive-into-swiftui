import SwiftUI

public extension View {
	
	func withHierarchyLoadingSpinner() -> some View {
		self
	}
	
	func isLoading(_ isLoading: Binding<Bool>) -> some View {
		self
	}
	
	func runInTerminalSection() -> some View {
		self
	}
}

private final class LoadingHandler: ObservableObject {
	
	/// `true` will determine the loading spinner to be displayed.
	@Published var isLoading: Bool = false
}

public struct HierarchyLoadingSpinnerModifier: ViewModifier {
	
	/// Intermediates the setter propagation logic and the `LoadingModifier` needs.
	@StateObject private var loadingHandler: LoadingHandler = .init()
	
	public init() { }
	
	// MARK: - ViewModifier implementation.
	
	public func body(content: Content) -> some View {
		content
			.environmentObject(loadingHandler)
	}
}

/// Extracts the `LoadingHandler` from the environment and modifies the value based
/// on the one passed in as parameter.
public struct IsLoadingModifier: ViewModifier {
	
	/// `true` if the loading spinner should be visible or not.
	public let isLoading: Binding<Bool>
	
	/// Intermediates the setter propagation logic and the `LoadingModifier` needs.
	@EnvironmentObject private var loadingHandler: LoadingHandler
	
	// MARK: - Init.
	
	public init(isLoading: Binding<Bool>) {
		self.isLoading = isLoading
	}
	
	// MARK: - ViewModifier
	
	public func body(content: Content) -> some View {
		content
			.onChange(of: isLoading.wrappedValue) { loadingHandler.isLoading = $0 }
	}
}
