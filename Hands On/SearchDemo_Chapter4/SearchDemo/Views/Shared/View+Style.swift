//
//  View+Style.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI

extension View {
	
	/// Applies `body` related appearance.
	func bodyStyle() -> some View {
		font(.body)
		.foregroundColor(Color.Text.tertiary.opacity(0.7))
	}
	
	/// Applies `headline` related appearance.
	func headlineStyle() -> some View {
		font(.headline)
		.foregroundColor(Color.Text.tertiary)
	}
}
