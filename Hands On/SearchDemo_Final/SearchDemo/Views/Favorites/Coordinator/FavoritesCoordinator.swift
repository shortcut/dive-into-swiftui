//
//  FavoritesCoordinator.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import Foundation
import SwiftUI
import ItunesApi

/// Handles the navigation within the `Favorites` feature flow.
protocol FavoritesCoordinator: DetailsCoordinator {
	
	/// Moves the focus to the `Search` tab.
	func goToSearch()
	
	/// Displays the `ItunesItem` details.
	/// - Parameter itemId: Uniquely identifies an `Itunes` item.
	func goToItemDetails(item: ItunesItem)
}

final class FavoritesCoordinating: ObservableObject, FavoritesCoordinator {
	
	/// 2 way binding for the `NavigationStack`.
	@Published var navigationPath: NavigationPath = .init()
	
	/// Handles cross tab navigation.
	weak var rootCoordinator: RootCoordinator?
	
	// MARK: - Dependencies.
	
	/// Handles the interaction with the local favorites data.
	let favoritesRepository: FavoritesRepository
	
	// MARK: - Init.
	
	// Tip: keep the RootCoordinator parameter as Optional so that it's easier to integrate with Xcode Previews.
	init(rootCoordinator: RootCoordinator?, favoritesRepository: FavoritesRepository) {
		self.rootCoordinator = rootCoordinator
		self.favoritesRepository = favoritesRepository
	}
	
	// MARK: - FavoritesCoordinator implementation.
	
	func goToSearch() {
		rootCoordinator?.goToSearch()
	}
	
	func goToItemDetails(item: ItunesItem) {
		navigationPath.append(SearchRoute.details(item: item))
	}
	
	func goToPosterDetails(url: URL) {
		navigationPath.append(DetailsRoute.imageDetails(url: url))
	}
}
