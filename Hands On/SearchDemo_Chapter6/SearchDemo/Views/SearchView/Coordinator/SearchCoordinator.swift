//
//  SearchCoordinator.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import Foundation
import SwiftUI
import ItunesApi

/// Stable identifier of the routes that are accessible in the `Search` feature flow.
enum SearchRoute: Hashable {
	
	/// Details page of an item in which more details are visible.
	case details(item: ItunesItem)
}

/// Handles the navigation within the `Search` feature flow.
protocol SearchCoordinator: DetailsCoordinator {
	
	/// Displays the `ItunesItem` details.
	/// - Parameter itemId: Uniquely identifies an `Itunes` item.
	func goToItemDetails(item: ItunesItem)
}

final class SearchCoordinating: ObservableObject, SearchCoordinator {
	
	/// 2 way binding for the `NavigationStack`.
	@Published var navigationPath: NavigationPath = .init()
		
	/// Handles cross tab navigation.
	private weak var rootCoordinator: RootCoordinator?
	
	/// Data layer dependency.
	let api: ItunesSearchServiceProtocol = ItunesSearchService()
	
	/// Handles the interaction with the local favorites data.
	let favoritesRepository: FavoritesRepository
	
	// MARK: - Init.
	
	// Tip: keep the RootCoordinator parameter as Optional so that it's easier to integrate with Xcode Previews.
	init(rootCoordinator: RootCoordinator?, favoritesRepository: FavoritesRepository) {
		self.rootCoordinator = rootCoordinator
		self.favoritesRepository = favoritesRepository
	}
	
	// MARK: - SearchCoordinator implementation.
	
	func goToItemDetails(item: ItunesItem) {
		navigationPath.append(SearchRoute.details(item: item))
	}
	
	func goToPosterDetails(url: URL) {
		navigationPath.append(DetailsRoute.imageDetails(url: url))
	}
}
