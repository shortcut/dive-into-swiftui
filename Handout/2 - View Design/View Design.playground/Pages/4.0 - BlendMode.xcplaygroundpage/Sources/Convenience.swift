import SwiftUI

extension BlendMode: Identifiable {
	
	public var id: String {
		description
	}
	
	public var description: String {
		switch self {
		case .normal:
			return "normal"
		case .multiply:
			return "multiply"
		case .screen:
			return "screen"
		case .overlay:
			return "overlay"
		case .darken:
			return "darken"
		case .lighten:
			return "lighten"
		case .colorDodge:
			return "colorDodge"
		case .colorBurn:
			return "colorBurn"
		case .softLight:
			return "softLight"
		case .hardLight:
			return "hardLight"
		case .difference:
			return "difference"
		case .exclusion:
			return "exclusion"
		case .hue:
			return "hue"
		case .saturation:
			return "saturation"
		case .color:
			return "color"
		case .luminosity:
			return "luminosity"
		case .sourceAtop:
			return "sourceAtop"
		case .destinationOver:
			return "destinationOver"
		case .destinationOut:
			return "destinationOut"
		case .plusDarker:
			return "plusDarker"
		case .plusLighter:
			return "plusLighter"
		@unknown default:
			return "unknown"
		}
	}
}

