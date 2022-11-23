//
//  RootCoordinator.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import Foundation
import ItunesApi
import SwiftUI

/// Handles the cross `TabBar` navigation.
protocol RootCoordinator: AnyObject {
	
	/// Moves the focus to the `Search` tab.
	func goToSearch()
	
	/// Displays the `ItunesItem` details.
	/// - Parameter itemId: Uniquely identifies an `Itunes` item.
	func goToItemDetails(item: ItunesItem)
}

final class RootCoordinating: ObservableObject, RootCoordinator {

	/// Stable identifier of the tabs within a `SwiftUI TabBar`.
	enum Tab { case search, favorites, itemOfTheDay }
	
	/// 2 way binding between which tab is currently focused and the `TabBar`.
	@Published var focusedTab: Tab = .search
	
	/// Handles the flow within the `search flow`.
	private(set) lazy var searchCoordinator: SearchCoordinating = .init(rootCoordinator: self, favoritesRepository: favoritesRepository)
	
	/// Handles the flow within the `favorites flow`.
	private(set) lazy var favoritesCoordinator: FavoritesCoordinating = .init(rootCoordinator: self, favoritesRepository: favoritesRepository)
	
	// MARK: - Dependencies.
	
	/// Handles the interaction with the local favorites data.
	let favoritesRepository: FavoritesRepository = .init()
	
	// MARK: - RootCoordinator implementation.
	
	func goToSearch() {
		focusedTab = .search
	}
	
	func goToItemDetails(item: ItunesItem) {
		// Change the tab if we're focused on it already.
		goToSearch()
		
		// Delegate the navigation to the
		searchCoordinator.goToItemDetails(item: item)
	}
}
