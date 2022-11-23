import Foundation

/// Routes available at launch time.
public enum AppRoute: Hashable {
	/// The user is now authenticated and can be presented with the home page.
	case authenticated(as: User)
	
	/// The user hasn't yet authenticated himself.
	case unauthenticated
}

/// Navigation paths that a non authenticated user can take.
public enum AuthenticationRoute: Hashable {
	/// The user wants to create an account and login.
	case signUp
	
	/// The user has an account and wants to login.
	case login
}

/// Navigation paths that an authenticated user can take.
public enum HomeRoute: Hashable {
	/// Presents the `emoji` in a bigger, better format.
	case emojiDetails(_ emoji: String)
}
