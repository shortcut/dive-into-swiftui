import Foundation
import SwiftUI

extension HorizontalAlignment: Identifiable, Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(stringValue)
	}

	public var stringValue: String {
		switch self {
		case .leading:
			return "leading"
			
		case .center:
			return "center"
			
		case .trailing:
			return "trailing"
			
		default:
			return "unknown"
		}
	}
	
	public var id: String {
		stringValue
	}
}

extension VerticalAlignment: Identifiable, Hashable {
	
	public func hash(into hasher: inout Hasher) {
		hasher.combine(stringValue)
	}
	
	public var stringValue: String {
		switch self {
		case .top:
			return "top"
			
		case .center:
			return "center"
			
		case .bottom:
			return "bottom"
			
		default:
			return "unknown"
		}
	}
	
	public var id: String {
		stringValue
	}
}
