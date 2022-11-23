import Foundation
import Combine

/// Defines a route to a flow/ leaf node in the application's navigation tree structure.
public enum Deeplink {
		
	/// An emoji details.
	case emoji(id: String)
}

/// Controls and intermediates the data flow of the `deeplink` through the view hierarchy.
public final class DeeplinkManager {
	
	/// Publishes values whenever the app is deeplinked or interacted with from a push notification.
	public var deeplinkPublisher: AnyPublisher<Deeplink, Never> {
		deeplinkSubject
			.compactMap { $0 }
			.eraseToAnyPublisher()
	}
	
	/// Store the deeplink until it's handled/ unhandled so that we do not lose it if there
	/// are no observers attached at the point of broadcasting it.
	private let deeplinkSubject: CurrentValueSubject<Deeplink?, Never> = .init(nil)
	
	/// Updates the new deeplink to be handled.
	/// - Parameter deeplink: Ultimately determines a route to where the application should navigate.
	public func publish(deeplink: Deeplink) {
		deeplinkSubject.send(deeplink)
	}
	
	/// Makes sure to cleanup a handled/ unhandled deeplink so that it does not lie around in memory
	/// nor is lost if we use a `PassthroughSubject`.
	public func cleanup() {
		deeplinkSubject.send(nil)
	}
}
