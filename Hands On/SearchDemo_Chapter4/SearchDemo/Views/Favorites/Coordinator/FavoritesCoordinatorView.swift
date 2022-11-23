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

	let favoritesRepository: FavoritesRepository
	
	// MARK: - Body.
	
	var body: some View {
		// Bind the stack to the path.
		NavigationView {
			FavoritesView()
				.navigationTitle(Text(L10n.Favorites.title))
		}
	}
}
