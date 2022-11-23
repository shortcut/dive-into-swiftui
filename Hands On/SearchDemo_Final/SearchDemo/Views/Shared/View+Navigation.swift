//
//  View+Navigation.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI

extension View {
	
	/// Handles the navigational requirements for the `DetailView`.
	/// - Parameters:
	///   - coordinator: Handles the navigation within that feature.
	///   - favoritesRepository: Handles favorites related data.
	func handleNavigationToDetails(detailsCoordinator coordinator: DetailsCoordinator, favoritesRepository: FavoritesRepository) -> some View {
		navigationDestination(for: SearchRoute.self) { route in
			switch route {
			case .details(let item):
				DetailView(viewModel: DetailView.ViewModel(item: item, favoritesRepository: favoritesRepository, coordinator: coordinator))
			}
		}
		.navigationDestination(for: DetailsRoute.self) { route in
			switch route {
			case .imageDetails(let url):
				AsyncImage(url: url) { image in
					image
						.resizable()
						.aspectRatio(contentMode: .fit)
				} placeholder: {
					ProgressView()
				}
			}
		}
	}
}
