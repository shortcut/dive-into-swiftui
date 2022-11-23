//: [Previous](@previous)

/*:
 # Hybrid
 
 For flexibility reasons, which will be obvious, we chose the `plug-and-play` version of the `Coordinator` so that it will impact as little as possible our previous `all SwiftUI` setup.
 */

import SwiftUI

final class Coordinator: BaseCoordinator {
	
	// 🔵
	weak var navigationController: UINavigationController?
	
	/// Where should we go as soon as we start? Are we already authenticated?
	let appRoute: AppRoute
	
	// MARK: - Init.
	
	init(appRoute: AppRoute) {
		self.appRoute = appRoute
	}
	
	func start() {
		// 🟢
		switch appRoute {
		case .authenticated(let user):
			push(HomeView(authenticatedUser: user), animated: true)
			
		case .unauthenticated:
			push(
				AuthenticationView(
					viewModel: AuthenticationViewModel(coordinator: self)
				),
				animated: true
			)
		}
	}
}

struct LaunchScreen : View {
	
	/// Backbone of the structured navigation 👈🏻
	let coordinator: Coordinator
	
	var body: some View {
		AuthenticationView(
			viewModel: AuthenticationViewModel(coordinator: coordinator)
		)
	}
}

/// For convenience, the same object can implement the `AuthenticationCoordinator` protocol.
extension Coordinator: AuthenticationCoordinator {
	
	func goToSignUp() {
		// 🟠
		push(SignUpView(), animated: true)
	}
	
	func goToLogin() {
		// 🟠
		push(LoginView(), animated: true)
	}
	
	func goToHome(authenticatedUser user: User) { /* ... */ }
}

final class AuthenticationViewModel: ObservableObject {
	
	/// Performs the navigation within the `Authenticating` scope.
	let coordinator: AuthenticationCoordinator
	
	// MARK: - Init.
	
	init(coordinator: AuthenticationCoordinator) {
		self.coordinator = coordinator
	}
	
	// MARK: - Public interface.
	
	/// Logic to be performed when the user interacts with the `Login` button.
	func loginAction() {
		coordinator.goToLogin()
	}
	
	/// Logic to be performed when the user interacts with the `Sign up` button.
	func signUpAction() {
		coordinator.goToSignUp()
	}
}

/// Root `View` for the authentication flow.
struct AuthenticationView: View {
	
	/// `@StateObject` is a small optimization here so that the `AuthenticationViewModel`
	/// is not re-created every time the `Coordinator` object publishes changes as a result of `path` mutation.
	@StateObject var viewModel: AuthenticationViewModel
	
	var body: some View {
		ScrollView {
			VStack {
				Group {
					Button("Login", action: viewModel.loginAction)
					Button("Sign up", action: viewModel.signUpAction)
				}
				.font(.title)
				.padding()
				.frame(maxWidth: .infinity)
				.background(.red)
				.clipShape(Capsule())
			}
			.fixedSize(horizontal: true, vertical: false)
		}
	}
}

//: [Next](@next)
