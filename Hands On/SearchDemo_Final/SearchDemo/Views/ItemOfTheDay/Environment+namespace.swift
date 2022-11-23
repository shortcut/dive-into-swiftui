//
//  Environment+namespace.swift
//  SearchDemo
//
//  Created by Coruț Fabrizio on 23.11.2022.
//

import SwiftUI

struct NamespaceEnvironment: EnvironmentKey {
	static var defaultValue: Namespace.ID?
}

extension EnvironmentValues {
	
	/// The `Namespace.ID` of the `parent` that is trying to perform a matched geometry effect animation.
	var parentAnimationNamespace: Namespace.ID? {
		get { self[NamespaceEnvironment.self] }
		set { self[NamespaceEnvironment.self] = newValue }
	}
}

extension View {
	
	/// Adds the corresponding `matchedGeometryEffect(id:in)` modifier for a `View` that might be part of
	/// an animation.
	/// - Parameter id: Uniquely identifies the elements for `Animation`.
	func matchGeometryEffectInDetailsAnimation(id: DetailsAnimationIdentifiers) -> some View {
		modifier(DetailsAnimationViewModifier(id: id))
	}
}

private struct DetailsAnimationViewModifier: ViewModifier {
	
	/// Possible namespace into which the animation is performed.
	@Environment(\.parentAnimationNamespace) private var namespace
	
	/// Uniquely identifies an element that should be animated.
	let id: DetailsAnimationIdentifiers
	
	// MARK: - ViewModifier implementation.
	
	func body(content: Content) -> some View {
		if let namespace {
			content
				.matchedGeometryEffect(id: id, in: namespace)
		} else {
			content
		}
	}
}
