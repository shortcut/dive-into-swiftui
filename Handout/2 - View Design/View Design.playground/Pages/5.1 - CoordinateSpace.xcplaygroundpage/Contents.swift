//: [Previous](@previous)

/*: # CoordinateSpace
 
 As previously seen, `GeometryReader` is a `View` whose content creation block provides as parameter a `GeometryProxy` object. Amongst the usual `.size` property, there is another interesting API:
 
 ```swift
 func frame(in coordinateSpace: CoordinateSpace) -> CGRect
 ```
 but what is a `CoordinateSpace`?
 Looking at its definition we find it to be a simple enum:
 
 ```swift
 public enum CoordinateSpace {

	 case global
	 case local
	 case named(AnyHashable)
 }
 ```
 The cases are fairly straightforward: `global` will return the frame of the container in the current context, `local` will return the same `size` as `global`, but the `origin` will always be `.zero`.
 The interesting case, though, is the `named`. It allows us to reference other `CoordinateSpaces`, each `View` has an associated `CoordinateSpace`, so basically, the frame of a `View` that is currently visible on the screen.
 The counterpart API for allowing us to name `CoordinateSpaces` can be found on `View`:
 ```swift
 @inlinable public func coordinateSpace<T>(name: T) -> some View where T : Hashable
 ```
 */

import SwiftUI
import PlaygroundSupport

struct ParallaxScroller: ViewModifier {
	let coordinateSpace: CoordinateSpace

	func body(content: Content) -> some View {
		// Hide the content because we do not want to display _this_ content.
		content
			.opacity(0)
			.overlay {
				// 👇🏻 whenever the scroll position changes this will be called, giving us the
				// value of the frame in the scrollView based on which
				// we can compute and perform the parallax effect.
				GeometryReader { proxy in
					// Place the content in the overlay as well so that we can visually
					// manipulate it however we want.
					content
						.offset(y: proxy.parallaxYTransform(relativeTo: coordinateSpace))
				}
			}
			.clipped()
	}
}

private extension GeometryProxy {
	func parallaxYTransform(relativeTo parentSpace: CoordinateSpace) -> CGFloat {
		let yGlobal = frame(in: parentSpace).origin.y

		if yGlobal > 0 {
			return 0
		} else {
			return -yGlobal / 2
		}
	}
}

extension View {
	func scrollViewHeader(coordinateSpace: CoordinateSpace) -> some View {
		modifier(ParallaxScroller(coordinateSpace: coordinateSpace))
	}
}

struct ContentView: View {
	
	private let coordinateSpaceName = "Demo"
	
	var body: some View {
		ScrollView {
			Image(uiImage: UIImage(named: "happy_dog.jpg")!)
				.resizable()
				.scaledToFit()
				// 👇🏻 here we inject the coordinate space into the header for parallaxing effect.
				.scrollViewHeader(coordinateSpace: CoordinateSpace.named(coordinateSpaceName))
			Text(loremIpsum)
				.padding()
		}
		// 👇🏻 here we define the coordinate space relative to which we want to get measurements.
		.coordinateSpace(name: coordinateSpaceName)
	}
}

PlaygroundPage.current.setLiveView(
	ContentView()
		.frame(width: 325, height: 675)
)

//: [Next](@next)
