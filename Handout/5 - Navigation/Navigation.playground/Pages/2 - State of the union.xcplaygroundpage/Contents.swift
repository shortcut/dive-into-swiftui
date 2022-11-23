//: [Previous](@previous)

/*: # State of the union
 
 Let's have a look at what `iOS 16` brings to the table in terms of structured navigation.
 
 ## NavigationStack
 
 As its name eludes to, it manages a `stack of Views` that are transitioned according to the `push`/ `pop` visual paradigm. The ways that `NavigationStack` exceeds `NavigationView` are:
 1. single source of truth for the stack of `Views`: `NavigationPath`; while this could have been achieved before the extra effort put into layering was not worth it and unstable between `SwiftUI versions`;
 2. better `APIs`: while the bound between where you _trigger the navigation from_ and where the _navigation destination resolution_ is declared is loose, the `API` is great in terms of both readability and flexibility;
 3. ability to `pop` to any point in the flow without having to manually care about the intermediary states;
 
 ## NavigationPath
 
 A type-erased array of elements, each of which a `destination View` should be configured with. It's the backbone of the new navigation paradigm as it represents the source of truth for what `Views` should be presented or not and when the navigation should be performed and in which direction.
 */

import SwiftUI
import PlaygroundSupport

/*:
 ## Dive in
 
 When we elaborate the navigation structure we usually like to define it in terms of `routes`. That helps us keep the scope the navigation to a certain flow, which also provides a good overview on the navigation destinations.
 If flows have common, one or multiple, screens the separation should exist at the `route` level nevertheless. The reusability of those `Views` should be ensured by the highest layer of navigation abstraction possible: usually a `Coordinator` component.
 Mapping navigation into routes and flows gives you a nice overview in terms of user experience: if you are allowing the user to navigate to the same screen from all the tabs of your application, maybe a better UX consideration could be made as redundancy can cause more confusion instead of bringing convenience.
 
 The `routes` are usually defined by `enums` for expressibility and compile time checks:
 */

/// Routes available at launch time.
enum AppRoute: Hashable {
	/// The user is now authenticated and can be presented with the home page.
	case authenticated(as: User)
	
	/// The user hasn't yet authenticated himself.
	case unauthenticated
}

/// Navigation paths that a non authenticated user can take.
enum AuthenticationRoute: Hashable {
	/// The user wants to create an account and login.
	case signUp
	
	/// The user has an account and wants to login.
	case login
}

/// Navigation paths that an authenticated user can take.
enum HomeRoute: Hashable {
	/// Presents the `emoji` in a bigger, better format.
	case emojiDetails(_ emoji: String)
}

/*:
 And in order to keep things as separated as possible, we define some coordinator protocols.
 
 💡 We like to use the `goTo` terminology so that we do not imply anything in terms of _how_ the navigation will be performed. Maybe on `iPad` we'll just use the split view details, on `iOS` we push and on `macOS` we'll present a new window.
 */

/// Manages app-wide navigation capabilities.
/// Is the central place to navigate base app navigation state.
protocol AppCoordinator {
	
	/// Displays the home page of the application. This is where the user session begins.
	/// - Parameter user: Required because certain functionalities do not make sense without the user being `authenticated`.
	func goToHome(authenticatedUser user: User)
	
	/// The user's session has ended and we cannot display authenticated content anymore.
	func logout()
}

/// Manages the navigation within the authentication flow.
/// Use this for facilitating: login and sign-up.
protocol AuthenticationCoordinator {
	
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
protocol HomeCoordinator {
		
	/// Presents the `emoji` in a bigger, better format.
	func goToEmojiDetails(emoji: Emoji)
	
	/// The user's session has ended and we cannot display authenticated content anymore.
	func logout()
}

/*:
 
 Now, in `SwiftUI`, as opposed to `UIKit`, the `Coordinator` pattern is a 2-part component:
 1. the `View` in which the `NavigationStack` is declared and the `destination` is handled: `.navigationDestination(_:content:)` implementation;
 2. the `Data` which represents the current navigation state: `NavigationPath`;
 
 In `UIKit` the "source of truth" was the `UINavigationController` keeping a reference to the `UIViewControllers` and hence a single component which kept a reference to the `UINavigationController` was sufficient. This is not applicable in this world.
 
 Ideally, each flow should have its own "coordinator" (`View` + `Data`) and navigation from one flow to another should be somehow intermediated and managed in a cross-coordinator way such that one coordinator will, ideally, never create a `View` that is originally part of another flow.
 */

import SwiftUI

/*:
 # App Scope
 */

final class Coordinator: ObservableObject {
	
	// 🔵
	/// Controls the `NavigationStack` and the whole app-wide navigation.
	@Published var path: NavigationPath = .init()
}

struct LaunchScreen: View {
	
	// 🔵
	/// Backbone of the structured navigation 👈🏻
	@StateObject private var coordinator: Coordinator = .init()
	
	var body: some View {
		// 🔵
		NavigationStack(path: $coordinator.path) {
			AuthenticationView(
				viewModel: AuthenticationViewModel(coordinator: coordinator)
			)
			// 🟢
			// Bridge the `Data` and the `View` components in a type-safe way.
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

/*:
 # Authenticated Scope
 */

/// For convenience, the same object can implement the `AuthenticationCoordinator` protocol.
/// ⚠️ `NavigationPath` is a `struct`. We can't simply create a new object and pass the `Coordinator.path` reference.
/// If multiple Coordinator Data objects are required we could use `Combine` to propagate the changes up to `Coordinator.path`.
extension Coordinator: AuthenticationCoordinator {
	
	func goToSignUp() {
		// ✅ add the route to the `NavigationPath` and let `.navigationDestination(for:destination:)` handle the rest.
		path.append(AuthenticationRoute.signUp)
	}
	
	func goToLogin() {
		// ✅ add the route to the `NavigationPath` and let `.navigationDestination(for:destination:)` handle the rest.
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
		// Declaring the `AuthenticationRoute` destination mapping further increases the scope and structure
		// of our navigation. If we want to go down an AuthenticationRoute, we should make sure to do it down this flow.
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

/*:
 ## Backwards navigation/ pop to root
 
 Hopefully by this point this is intuitive enough that while pushing new `values` in `NavigationPath` triggers `Views` to be added, removing `values` will determine `removing/ popping` the `Views` that were previously mapped to them.
 This makes `pop to root` functionality a walk in the park.
 
 ## Gotchas and differences

 Looking at `NavigationLink.init(_:destination:)` API I can see how `View.navigationDestination(for:destination:)` can cause slight confusion. While the  `NavigationLink` API acts like a **toggle** (the `destination` is either presented or not), the latter does not.
 `View.navigationDestination(for:destination:)` acts like a `map` function that simply knows how to translate a `value` to a `View`. It doesn't keep any state and it handles no state. So, if we push the same `value` twice, two identical `Views` will be pushed.
 
 Let's look at the following example:
 */

enum Route { case first, second }

struct NavigationLinkExample: View {

	/// Use the same `enum` based `Route` in trying to structure the navigation, type-safe it and get compile warnings.
	@State private var route: Route?
	
	/// Since `NavigationLink` requires  `Binding<Bool>` we'll map a `nil` value to `false` and `.some()` to `true`.
	private var routeBinding: Binding<Bool> {
		// nullifying the route in `set` is expected since the value will be only set to `false` by `SwiftUI` when navigating backwards.
		.init(get: { route != nil }, set: { _ in route = nil })
	}
	
	var body: some View {
		NavigationView {
			VStack {
				Button("First flow", action: { route = .first })
				Button("Second flow", action: { route = .second })
				
				NavigationLink(isActive: routeBinding) {
					routeDestination
				} label: {
					EmptyView()
				}
			}
		}
	}
	
	/// Where to navigate to based on `Route`.
	@ViewBuilder private var routeDestination: some View {
		if let route {
			switch route {
			case .first:
				FirstView(route: $route)
				
			case .second:
				SecondView()
			}
		} else {
			EmptyView()
		}
	}
}

struct FirstView: View {
	
	@Binding var route: Route?
	
	var body: some View {
		ZStack {
			Color.yellow
				.ignoresSafeArea()
			
			// ❌ After pressing the button `route` will be changed, `NavigationLinkExample.routeDestination` will be triggered,
			// but instead of pushing the new route, `FirstView` will be replaced, without animations`.
			Button("Go to second!", action: { route = .second })
		}
	}
}

struct SecondView: View {
	
	var body: some View {
		ZStack {
			Color.green
				.ignoresSafeArea()
			
			Text("Second view.")
		}
	}
}

/*:
 
 ## Conclusions
 
 This is just _a way_ of dealing and structuring your code using `NavigationStack` and `NavigationPath`. We am sure there are various other approaches, more or less scoped to perform navigation but this is the one we feel comfortable with in order to root out possible unexpected states and flows.

 Since we have already brought it into discussion, `NavigationLink` has also been enhanced with a new API allowing it to interact directly with `NavigationStack` and `NavigationPath`: [init(_:value:)](https://developer.apple.com/documentation/swiftui/navigationlink/init(_:value:)-kj9v?changes=_5), [init(_:value:)](https://developer.apple.com/documentation/swiftui/navigationlink/init(_:value:)-91u0d?changes=_5), [init(value:label:)](https://developer.apple.com/documentation/swiftui/navigationlink/init(value:label:)-4jswo?changes=_5) .
 
The sad news is that those APIs are all `iOS 16+` (but maybe [this](https://forums.swift.org/t/se-0376-function-back-deployment/61015) might help us in the near future). Good news, though, for the adventurers out there, there is already an effort to backport the navigation concepts to previous `SwiftUI` versions. Make sure to [check it out](https://github.com/johnpatrickmorgan/NavigationBackport).
 
 The complexity at which you want to go with the layering and `Coordinator` depends a lot on on the complexity of the project. For most of the projects `NavigationView` and `NavigationLink` did the job, for some the intricacy of flows made it impossible, for others the implementation differences between `iOS 13` and `14` made it too unpredictable and patching all the scenarios was not worth the effort etc. But we salute them 🫡 and are eager to share our experience and possible solution that might fit your scenario 🚀 press on [Next](@next) to find out more.
 */

//: [Next](@next)
