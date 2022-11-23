import Foundation
import UIKit

public struct SessionManager {
	
	public init() { }
}

public final class AuthenticationNavigationController: UINavigationController {
	
	public init(sessionManager: SessionManager) {
		super.init(nibName: nil, bundle: nil)
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
