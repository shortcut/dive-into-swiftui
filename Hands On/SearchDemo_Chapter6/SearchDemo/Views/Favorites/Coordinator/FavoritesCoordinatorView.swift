//
//  FavoritesCoordinatorView.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import Foundation
import SwiftUI

/// Visual counterpart of the `FavoritesCoordinator`.
struct FavoritesCoordinatorView: View {

	/// Controls the navigation within the `search` flow.
	@ObservedObject var coordinator: FavoritesCoordinating
	
	// MARK: - Body.
	
	var body: some View {
		// Bind the stack to the path.
		NavigationStack(path: $coordinator.navigationPath) {
			FavoritesView(viewModel: FavoritesView.ViewModel(favoritesCoordinator: coordinator, favoritesRepository: coordinator.favoritesRepository))
				.navigationTitle(Text(L10n.Favorites.title))
				.handleNavigationToDetails(detailsCoordinator: coordinator, favoritesRepository: coordinator.favoritesRepository)
		}
	}
}
