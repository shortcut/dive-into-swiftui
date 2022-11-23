import Foundation
import UIKit
import SwiftUI

/// Implementing this would go out of the scope of the handout.
public typealias Emoji = String
public typealias User = String

/// Manages app-wide navigation capabilities.
/// Is the central place to navigate base app navigation state.
public protocol AppCoordinator {
	
	/// Displays the home page of the application. This is where the user session begins.
	/// - Parameter user: Required because certain functionalities do not make sense without the user being `authenticated`.
	func goToHome(authenticatedUser user: User)
	
	/// The user's session has ended and we cannot display authenticated content anymore.
	func logout()
}

/// Manages the navigation within the authentication flow.
/// Use this for facilitating: login and sign-up.
public protocol AuthenticationCoordinator {
	
	/// Displays a page in which the user can create an account.
	func goToSignUp()
	
	/// Displays the page in which the user authenticate his existing account.
	func goToLogin()
	
	/// Displays the home page of the application. This is where the user session begins.
	/// - Parameter user: Required because certain functionalities do not make sense without the user being `authenticated`.
	func goToHome(authenticatedUser user: User)
}

/// Manages the navigation within the authenticated scope.
/// At this point we have a `User` and it's authenticated.
public protocol HomeCoordinator {
		
	/// Presents the `emoji` in a bigger, better format.
	func goToEmojiDetails(emoji: Emoji)
	
	/// The user's session has ended and we cannot display authenticated content anymore.
	func logout()
}

/// Convenience base interface required for coordinating `Views`.
public protocol BaseCoordinator {
	
	var navigationController: UINavigationController? { get set }
	
	/// It is at this point that the `Coordinator` is considered loaded and ready to start its flow.
	func start()
}

public extension BaseCoordinator {
	
	func push<V: View>(_ view: V, animated: Bool) {
		
	}
}
