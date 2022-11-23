//: [Previous](@previous)

/*: # Deeplinks
 
 One of the biggest advantages that comes with structured navigation is the ease of incorporating deep/ universal link handling.
 The integration, streamline, convenience and ecosystem-like feeling that you get out of being able to use the app instead of a website, or continue the work on an application that you have started on another application, or being able to authenticate yourself using FaceID/ TouchID and continue the work on your browser are sometimes things that we take for granted.
 
 Let's take a closer look on how we can add linking capabilities:
 
 ## All SwiftUI:
 */

import SwiftUI
import Combine

final class SUI_Coordinator: ObservableObject {
	
	/// Controls the navigation stack.
	@Published var path: NavigationPath = .init()

	/// Keeps the subscription to deeplink publisher alive.
	private var deeplinkSubscription: AnyCancellable?
	
	/// - Parameter deeplinkManager: Publishes events for when a deep/ universal link has been passed down to the app.
	init(deeplinkManager: DeeplinkManager) {
		deeplinkSubscription = deeplinkManager.deeplinkPublisher
			.receive(on: RunLoop.main)
			.sink { [weak self] newDeeplink in
				// ⚠️ here is the place where you can do some clean-up
				// of the path before performing the deeplink navigation.
				
				switch newDeeplink {
				case .emoji(let id):
					self?.path.append(HomeRoute.emojiDetails(id))
				}
				
				// Clean-up only if we have handled the deeplink.
				deeplinkManager.cleanup()
			}
	}
}

/*:
 
## Hybrid:
*/

final class UIK_Coordinator: BaseCoordinator, HomeCoordinator {
	
	weak var navigationController: UINavigationController?
	
	/// Where should we go as soon as we start? Are we already authenticated?
	let appRoute: AppRoute
	
	/// Publishes events for when a deep/ universal link has been passed down to the app.
	let deeplinkManager: DeeplinkManager
	
	/// Keeps the subscription to deeplink publisher alive.
	private var deeplinkSubscription: AnyCancellable?
	
	// MARK: - Init.
	
	init(appRoute: AppRoute, deeplinkManager: DeeplinkManager) {
		self.appRoute = appRoute
		self.deeplinkManager = deeplinkManager
	}
	
	func start() {
		/* ... */
		deeplinkSubscription = deeplinkManager.deeplinkPublisher
			.receive(on: RunLoop.main)
			.sink { [weak self] newDeeplink in
				// ⚠️ here is the place where you can do some clean-up
				// of the path before performing the deeplink navigation.
				
				switch newDeeplink {
				case .emoji(let id):
					self?.goToEmojiDetails(emoji: id)
				}
				
				// Clean-up only if we have handled the deeplink.
				self?.deeplinkManager.cleanup()
			}
	}
	
	// MARK: - HomeCoordinator implementation.
	
	func goToEmojiDetails(emoji: Emoji) {
		push(EmojiDetails(emoji: emoji), animated: true)
	}
	
	func logout() { }
}

/*:
 
 As we can see, the addition to handle deeplinks in a reusable, structured way is more simpler and implies no changes to any `View`/ `business logic` layer.
 Of course, this is just an example of how a simple app could structure its deep/ universal link handling. More intricate structures can be derived off of this in which you could have a linked list of deeplink managers that each is responsible for its own flow: this way, you perform DFS on the list until a `Coordinator` can handle the navigation.
 */

//: [Next](@next)
