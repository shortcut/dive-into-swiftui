//: [Previous](@previous)

/*:
 # Conclusion
 
 While the structure and scoping of flows is still present in the hybrid implementation and, if designed properly the changes between it and the all SwiftUI version are minimum, there are some considerations to watch out for when starting down the `hybrid` road:
 
 **1.** `Environment` and `EnvironmentObject` instances are **not** propagated between screens because the `Views` are not bound by a `SwiftUI` component, they are bound by `UINavigationController`; however there is a way for you to do that but I will touch on that a bit further down; 🧅
 **2.** same rule and reasoning applies for when we're `presenting Views modally`;
 **3.** depending on your setup you might not be able to use the convenient `@main struct MyApp: App` declaration of the app's entry point and still have to get down into `UIApplicationDelegate`/ `UIWindowSceneDelegate` world; 🧅
 **4.** by not being able to go all SwiftUI you might to a certain extent cut down on the device targets that you can ship your app to since you lose the `SwiftUI` magic that makes the same code run on: watch, TV, Mac, iPhone and iPad;
 **5.** for some `SwiftUI` versions the `UINavigationController` can act differently and this can be a source of frustration to the point of it being a deal breaker; so watch out for them!
 Some of the problems that we've had with it is the way that `SwiftUI`, throughout its different versions, works together with the native `UIKit components`. Just as the appearance of `List` was being influenced by changing the appearance on `UITableView` (because probably `List` was using either `UITableView` or just the appearance aspects of it), the same applies for this situation but in the opposite direction:
 APIs like: `.navigationTitle(title:)`, `.navigationBarHidden(hidden:)` interact with `UIKit` in the way that they would interact with `SwiftUI` counterpart components. And the sad part is that the navigation bar is always displayed in `SwiftUI Views`. Which means that your navigation bar will always be displayed in each `View` unless you explicitly set it hidden. One way of doing it, if you, like us sometimes, have a custom `navigation bar` is:
 */

import UIKit
import SwiftUI

/// Prevents the native navigation bar from being displayed as, by default, when
/// interacting with `SwiftUI` it will be set to visible.
class BarlessNavigationController: UINavigationController {
		
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		setNavigationBarHidden(true, animated: false)
	}
}

/*:
 
But furthermore, if you want to keep the native navigation bar displayed but remove the default "Back" button on a certain screen, that's also an explicit opt-out that we have to code for:
 
 */

/// Prevents the native "Back" navigation button from being displayed.
class BarlessHostingController<C: View>: UIHostingController<C> {
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		navigationItem.setHidesBackButton(true, animated: false)
	}
}

/*:
 
 The main reason we're doing the overrides as opposed to using the `.navigationBarBackButtonHidden(_:)` View modifier is that sometimes this does not work as intended in conjunction with the `interactive pop gesture` of the `UINavigationController`. We have experienced glitches, again, based on the SwiftUI version, where the navigation bar would be shown for a brief second just when performing the pop gesture.
 
 **6.** Extra layering, or **the onion**: 🧅
 Depending on the use case and the design of your code you might still want to get some of the nice conveniences of `SwiftUI`: being able to present something on top of a flow if by using the `.overlay` ViewModifier on the root `View`. This is impeded by the hybrid approach because the root `View` is actually a `UINavigationController`. Another convenience is being able to inject through a whole flow `Environment` values or `EnvironmentObjects` and that, again, is not possible because the component that binds the `SwiftUI Views` is not a `SwiftUI` component itself, is the `UIKit UINavigationController` and the boundary cannot be crossed.
 
 Inter-op to the rescue! The SwiftUI - UIKit inter operability is happily a 2 way road. Which means that we could wrap our root `UINavigationController` into a `View`. `UIViewControllerRepresentable` is a protocol allows us to port a `UIKit` component that is either a `subclass of` or `UIViewController` itself to a `SwiftUI View`.
 */

/// Transforms a `UIViewController` subclass into a `SwiftUI View`.
struct ViewControllerAdaptor<Destination: UIViewController>: UIViewControllerRepresentable {
	
	/// The `UIKit` counterpart that we're representing.
	let viewController: () -> Destination
	
	/// Called each time `updateUIViewController(_:context:)` method is called.
	let update: (() -> Void)?
	
	// MARK: - Init.
	
	init(viewController: @autoclosure @escaping () -> Destination, update: (() -> Void)? = nil) {
		self.viewController = viewController
		self.update = update
	}
	
	// MARK: - UIViewControllerRepresentable implementation.
	
	func makeUIViewController(context: Context) -> some UIViewController {
		viewController()
	}
	
	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
		update?()
	}
}

extension UIViewController {
	
	/// Transposes the `UIViewController` into a `SwiftUI View`.
	func toSwiftUIView() -> some View {
		ViewControllerAdaptor(viewController: self)
	}
}

// @main <- this is commented so that the playground does not complain.
struct MyApp: App {
	
	var body: some Scene {
		WindowGroup {
			// 👇🏻 this is a UINavigationController subclass.
			AuthenticationNavigationController(sessionManager: SessionManager())
				// 🪄 now it's a SwiftUI View.
				.toSwiftUIView()
				// from this point down you unlock all the SwiftUI conveniences:
				// inject `Environment` values, `EnvironmentObjects`, add `ViewModifiers` etc.
		}
	}
}

/*:
 
 Although this looks simple and straightforward, the layering fiasco can start when you want to `present` a new flow, hence, a new `UINavigationController`.
 
 • Following from the leaves to the root:
 `View` -> `UIHostingController` -> `UINavigationController` -> `UIViewControllerRepresentable`;
 
 so, instead of no layers, we first transform the `View` to a `UIKit` component for us to be able to push to the `UINavigationController` which, in his turn, is wrapped up in a `View`. So we're making a full circle of going back-and-forth between `SwiftUI` and `UIKit` just so we can use the hybrid approach while still getting the best out of `SwiftUI`. _4 layers in total_.
 
 • When presenting a new flow:
 `Presented_View` -> `UIHostingController` -> `Presented_UINavigationController` -> `UINavigationController` -> `UIViewControllerRepresentable`; _5 layers in total_.
 
 While it sounds like much we did not observe any performance issues when using the hybrid version of the navigation and once we had our convenience tools set up it was only smooth sailing from there.
 
 Navigation is a complex topic and we could go on and on about different solutions: VIPER, FlowControllers, FlowCoordinators etc. And is exactly its complexity that prevents it from having a silver bullet.
 Analyse the requirements of your application, the intricacy of your flows and navigation and draw conclusions based on that: maybe `SwiftUI NavigationView` does the job and you do not need all the layering and structure; maybe your deep/ universal linking logic demands structure and clear separation of flows (you will not be able to nicely deep/ universal link to a certain screen in a flow if only the previous screen triggers the navigation to it).
 */

//: [Next](@next)
