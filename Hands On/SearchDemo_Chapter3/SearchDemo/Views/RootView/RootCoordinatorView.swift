//
//  RootCoordinatorView.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI
import ItunesApi

struct RootCoordinatorView: View {
	
	/// Master handler of the navigation.
	@StateObject private var coordinator: RootCoordinating = .init()
	
	// MARK: - View.
	
    var body: some View {
		TabView(selection: $coordinator.focusedTab) {
			SearchCoordinatorView()
				.tabItem {
					Label(L10n.Search.Tabbar.title, systemImage: "magnifyingglass")
				}
				.tag(RootCoordinating.Tab.search)
			FavoritesCoordinatorView(favoritesRepository: coordinator.favoritesRepository)
				.tabItem {
					Label(L10n.Favorites.Tabbar.title, systemImage: "list.star")
				}
				.tag(RootCoordinating.Tab.favorites)
			ItemOfTheDayView()
				.tabItem {
					Label(L10n.ItemOfTheDay.Tabbar.title, systemImage: "calendar")
				}
				.tag(RootCoordinating.Tab.itemOfTheDay)
		}
		.environmentObject(coordinator.favoritesRepository)
		.tint(Color(asset: Asset.Colors.mandarinJelly))
		.withHierarchyLoadingSpinner()
    }
}

struct RootView_Previews: PreviewProvider {
    class BundleId {}

    static var results: [ItunesItem] = {
        do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601

            return try jsonDecoder
                .decode([ItunesItem].self,
                        from: NSDataAsset(name: "Results")!.data)
        } catch {
            fatalError(error.localizedDescription)
        }
    }()

    static var firstItem: ItunesItem! {
        results.first
    }

    struct MockSearch: ItunesSearchServiceProtocol {
        func search(for query: ItunesSearchQuery) async throws -> [ItunesItem] {
            return await RootView_Previews.results
        }
    }

    static var previews: some View {
        RootCoordinatorView()
    }
}
