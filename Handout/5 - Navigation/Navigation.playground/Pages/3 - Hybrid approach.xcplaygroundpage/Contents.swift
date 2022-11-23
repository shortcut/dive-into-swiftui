//: [Previous](@previous)

/*: # What can you do in the meantime?
 ## Hybrid approach
 
 As hinted in the previous section, for most of the developers out there, `iOS 16` as a minimum version target is a luxury that might come as early as next year (this is just an optimistic view based on the fast pace of iOS adoption and also by the big span of older devices compatibility). So, what can you do in the meantime?
 
 The most reliant version of structured navigation that we could find is a hybrid approach in which the backbone is `UINavigationController` and each `SwiftUI View` is transformed into a `UIViewController` through [UIViewControllerRepresentable](https://developer.apple.com/documentation/swiftui/uiviewcontrollerrepresentable). While the combination is not ideal, Apple gave us this Rosetta-like tool for a reason: be it for slow adoption of `SwiftUI` in `UIKit` applications or to workaround the functionality that is still missing in `SwiftUI` (don't even get us started on `TextEditor`).
 
 The bedrock for a solid and flexible navigation design is to keep the code that performs the navigation in its own layer and interact with it only through `protocols`. In this way, if your `Views` doesn't interact with any navigation code, if your `ViewModel` doesn't perform the navigation/ destination resolution either and instead they are wrapped in a `Coordinator` (or `FlowController` for that matter) you can, theoretically, swap in-and-out implementations without affecting any business logic or having to change too much code from `Views`/ `ViewModels`.
 The `Coordinator` can be either a simple `class` that we have seen in the previous section that manages the `NavigationPath` or it can be a `UINavigationController` subclass that performs the navigation and handles state at the same time.
 */

import UIKit

final class MainCoordinator_Subclass: UINavigationController {
	
	func goToLogin() {
		// push(LoginView(), animated: true)
	}
	
	func goToSignUp() {
		// push(SignUpView(), animated: true)
	}
}

/*:

 Or better yet it can be a `class` referencing a `UINavigationController` and delegating all the navigation _on it_. This brings an extra layer of flexibility because we don't bind the navigation logic to a certain `UINavigationController` instance but instead we can use _any_ `UINavigationController` instance. This is ideal for imbricated flows that use the same `UINavigationController`: the inner flow doesn't need and **can't be** a new `UINavigationController` (can't push a `UINavigationController` in a `UINavigationController`) but instead it uses the same to navigate through.
 
 This is basically the `plug-and-play` version of `Coordinator`. And the possibilities are numerous:
 - protocol for each flow and and sub-flow;
 - default implementations for reusability etc;
 */

final class MainCoordinator {
	
	weak var navigationController: UINavigationController?
	
	func goToLogin() {
		// navigationController?.push(LoginView(), animated: true)
	}
	
	func goToSignUp() {
		// navigationController?.push(SignUpView(), animated: true)
	}
}

/*:
 Next, we want to take another look at how the SwiftUI (iOS 16+) approach works, makring some relevant signposts, and do a "side-by-side" comparison between it and the hybrid implementation.
 */

//: [Next](@next)
