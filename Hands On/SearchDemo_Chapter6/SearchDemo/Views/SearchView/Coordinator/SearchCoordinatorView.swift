//
//  SearchCoordinatorView.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import Foundation
import SwiftUI
import ItunesApi

/// Visual counterpart of the `SearchCoordinator`.
struct SearchCoordinatorView: View {

	/// Controls the navigation within the `search` flow.
	@ObservedObject var coordinator: SearchCoordinating
	
	// MARK: - Body.
	
	var body: some View {
		// Bind the stack to the path.
		NavigationStack(path: $coordinator.navigationPath) {
			SearchView(viewModel: SearchView.ViewModel(coordinator: coordinator, api: coordinator.api))
				.navigationTitle(Text(L10n.Search.title))
				.handleNavigationToDetails(detailsCoordinator: coordinator, favoritesRepository: coordinator.favoritesRepository)
		}
	}
}
