//: [Previous](@previous)

/*: Blend Mode
 
 Provides an API for specifying the `visual aspect` and `result` of two or more overlapping `Views`. This is powerful tool when it comes to rich visual effects.
 */

import SwiftUI
import PlaygroundSupport

struct BlendModeDemo: View {
	
	private let allBlends: [BlendMode] =  [.normal, .multiply, .darken, .colorBurn, .hardLight, .difference, .exclusion, .luminosity, .sourceAtop, .destinationOut, .plusDarker
	]
	
	@State private var blendMode: BlendMode = .normal
	
	var body: some View {
		VStack {
			composition
			Picker("Blend Mode", selection: $blendMode) {
				ForEach(allBlends) {
					Text($0.description)
						.tag($0)
				}
			}
			.padding()
		}
	}
	
	/// Code inspired from: https://www.hackingwithswift.com/books/ios-swiftui/special-effects-in-swiftui-blurs-blending-and-more
	private var composition: some View {
		ZStack {
			Circle()
				.fill(Color.red)
				.frame(width: 200, height: 200)
				.offset(x: -50, y: -80)
				.blendMode(blendMode)
			
			Circle()
				.fill(Color.green)
				.frame(width: 200, height: 200)
				.offset(x: 50, y: -80)
				.blendMode(blendMode)
			
			Circle()
				.fill(Color.blue)
				.frame(width: 200, height: 200)
				.blendMode(blendMode)
		}
	}
}

PlaygroundPage.current.setLiveView(
	BlendModeDemo()
		.frame(width: 600, height: 600)
)

/*
 # Compositing Group
 
 Another API that goes hand in hand with `BlendModes` is `compositingGroup()`. This rendering pipeline tool taps into the order in which different `blendMode` and/ or `opacity` effects are applied. It basically creates different stages which are different than the default mode in which effects/ opacities are applied/ inherited/ distributed to `Views`.
 
 Another effect of using `compositingGroup()` is that the effects will be applied to the `View` as a whole, as opposed to effects being applied to single `Views` separately. With this in mind, this also allows us to better synchronize multiple animations within a container.
 */

struct PlayTabIcon: View {
	
	@Environment(\.colorScheme) private var colorScheme
	
	var tintColor: Color = .red
	
	var body: some View {
		RoundedRectangle(cornerRadius: 15.0)
			.fill(tintColor)
			.overlay(
				Image(systemName: "play.circle")
					.resizable()
					.scaledToFit()
					.frame(width: 50.0, height: 50.0)
					.blendMode(colorScheme == .light ? .normal : .destinationOut)
					.foregroundColor(.blue)
			)
			// By removing `compositingGroup`, instead of the play circle image being carved out
			// into an alpha channel (allowing us to see the background through) it would be instead
			// rendered to Color.black.
			.compositingGroup()
			.frame(width: 100.0, height: 80.0)
	}
}

struct OverlappingIcon: View {
	
	var body: some View {
		ZStack {
			Circle()
				.fill(Color.red)
				.frame(width: 100, height: 100)
				.offset(x: -25)
			
			Circle()
				.fill(Color.red)
				.frame(width: 100, height: 100)
				.offset(x: 25)
		}
	}
}

struct ContentView: View {
	
	var body: some View {
		PlayTabIcon()
		PlayTabIcon()
			.environment(\.colorScheme, .dark)
		OverlappingIcon()
			.opacity(0.5)
		OverlappingIcon()
			// Opacity applies to the group, instead of individual Views.
			.compositingGroup()
			.opacity(0.5)
	}
}



PlaygroundPage.current.setLiveView(
	ContentView()
		.frame(width: 200.0)
		.padding()
		.background(Color.yellow)
)

//: [Next](@next)
