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

	// MARK: - Animation parameters.
	
	@State private var firstStageCompleted: Bool = false
	@State private var secondStageCompleted: Bool = false
	@State private var intermediaryStateCompleted: Bool = false
	@State private var thirdStageCompleted: Bool = false
	
	// MARK: - View.
	
    var body: some View {
		TabView(selection: $coordinator.focusedTab) {
			SearchCoordinatorView(coordinator: coordinator.searchCoordinator)
				.tabItem {
					Label(L10n.Search.Tabbar.title, systemImage: "magnifyingglass")
				}
				.tag(RootCoordinating.Tab.search)
			FavoritesCoordinatorView(coordinator: coordinator.favoritesCoordinator)
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
		.scaleEffect(secondStageCompleted ? 1.0 : 0.7)
		.opacity(secondStageCompleted ? 1.0 : 0.0)
		.task {
            withAnimation(.interpolatingSpring(stiffness: 2, damping: 0.4).speed(8).delay(1.5)) {
				firstStageCompleted = true
			}
			withAnimation(.linear.delay(2.4)) {
				intermediaryStateCompleted = true
			}
			withAnimation(.default.speed(0.4).delay(2.4)) {
				secondStageCompleted = true
			}
			withAnimation(.default.delay(2.6)) {
				thirdStageCompleted = true
			}
		}
		.overlay {
			twitterStyleOverlay
				.opacity(thirdStageCompleted ? 0.0 : 1.0)
		}
		.tint(Color(asset: Asset.Colors.mandarinJelly))
		.withHierarchyLoadingSpinner()
    }
	
	/// The overlay that we'll zoom out so that we can see the actual display underneath.
	private var twitterStyleOverlay: some View {
		ZStack {
			Color(asset: Asset.Colors.airOfDebonair)
				.ignoresSafeArea()
			Group {
				logoView
                    .blendMode(.destinationOut)
					.scaleEffect(secondStageCompleted ? 20.0 : 0.4)
				logoView
					.opacity(intermediaryStateCompleted ? 0.0 : 1.0)
					.scaleEffect(firstStageCompleted ? 0.7 : 1.0)
			}
		}
		.compositingGroup()
	}
	
	/// Reusable logoView for initial animation.
	private var logoView: some View {
		Image(asset: Asset.Assets.itunes)
			.resizable()
			.scaledToFit()
			.frame(width: 100.0)
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
