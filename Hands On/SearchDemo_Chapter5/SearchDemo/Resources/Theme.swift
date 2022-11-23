//
//  Theme.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import Foundation
import SwiftUI

extension Color {
	
	static let background: Color = Color(asset: Asset.Colors.infinity)
	
	enum Text {
		static let primary: Color = Color(asset: Asset.Colors.white)
		static let secondary: Color = Color(asset: Asset.Colors.superSilver)
		static let tertiary: Color = Color(asset: Asset.Colors.quietShade)
		static let quaternary: Color = Color(asset: Asset.Colors.mandarinJelly)
		static let quinary: Color = Color(asset: Asset.Colors.atmosphere)
	}
	
	enum UIElement {
		static let primary: Color = Color(asset: Asset.Colors.atmosphere)
		static let secondary: Color = Color(asset: Asset.Colors.indiaInk)
		static let tertiary: Color = Color(asset: Asset.Colors.infinity)
		static let quaternary: Color = Color(asset: Asset.Colors.skyCaptain)
	}
	
	enum Icon {
		static let primary: Color = Color(asset: Asset.Colors.atmosphere)
		static let secondary: Color = Color(asset: Asset.Colors.superSilver)
		static let tertiary: Color = Color(asset: Asset.Colors.quietShade)
		static let quaternary: Color = Color(asset: Asset.Colors.mandarinJelly)
	}
}
