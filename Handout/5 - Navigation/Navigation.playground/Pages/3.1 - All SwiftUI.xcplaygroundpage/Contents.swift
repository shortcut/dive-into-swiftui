//: [Previous](@previous)

import SwiftUI

/*:
 Follow the matching color emojis (🟢🔵🟠) to help you keep track where the same functionality code has moved from and to, if applicable between the implementations.
 
 # All SwiftUI
 */

final class Coordinator: ObservableObject {
	
	// 🔵
	@Published var path: NavigationPath = .init()
}

struct LaunchScreen: View {
	
	// 🔵
	@StateObject private var coordinator: Coordinator = .init()
	
	var body: some View {
		// 🔵
		NavigationStack(path: $coordinator.path) {
			AuthenticationView(
				viewModel: AuthenticationViewModel(coordinator: coordinator)
			)
			// 🟢
			.navigationDestination(for: AppRoute.self) { baseRoute in
				switch baseRoute {
				case .authenticated(let user):
					HomeView(authenticatedUser: user)
					
				case .unauthenticated:
					// If we choose to replace the whole hierarchy with [.unauthenticated] we should be able
					// to go back to the initial screen.
					AuthenticationView(viewModel: AuthenticationViewModel(coordinator: coordinator))
				}
			}
		}
	}
}

extension Coordinator: AuthenticationCoordinator {
	
	func goToSignUp() {
		path.append(AuthenticationRoute.signUp)
	}
	
	func goToLogin() {
		path.append(AuthenticationRoute.login)
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
		.navigationDestination(for: AuthenticationRoute.self) { authenticationRoute in
			switch authenticationRoute {
			case .signUp:
				// 🟠
				SignUpView()
				
			case .login:
				// 🟠
				LoginView()
			}
		}
	}
}

//: [Next](@next)
