//
//  DetailsCoordinator.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import Foundation

/// Stable identifier of the routes that are accessible in the `Search` feature flow.
enum DetailsRoute: Hashable {
	
	/// Full screen version of the `ItunesItem` poster.
	case imageDetails(url: URL)
}

/// Handles the navigation from `Itunes details`.
protocol DetailsCoordinator: AnyObject {
		
	/// Displays the full screen version of an `ItunesItem's` poster.
	/// - Parameter url: Where the poster can be found.
	func goToPosterDetails(url: URL)
}

