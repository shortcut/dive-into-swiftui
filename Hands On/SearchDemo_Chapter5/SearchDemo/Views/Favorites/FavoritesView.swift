//
//  FavoritesView.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI
import Combine
import ItunesApi

struct FavoritesView: View {
	
	/// Handles the interaction with favorites.
	@StateObject var viewModel: ViewModel
	
	// 🔵 Chapter 5 hands on: we can definitely find a better solution..
	@State private var selectedItem: ItunesItem?
	
	// MARK: - Body.
	
    var body: some View {
		FavoritesContentView(
			items: viewModel.favorites,
			itemAction: { selectedItem = $0 },
			favoriteAction: viewModel.removeFromFavoritesAction(indexSet:),
			emptyAction: viewModel.emptyListAction
		)
			.background {
				NavigationLink(isActive: Binding(get: { selectedItem != nil }, set: { _ in selectedItem = nil })) {
					if let selectedItem {
						DetailView(viewModel: DetailView.ViewModel.init(item: selectedItem, favoritesRepository: viewModel.favoritesRepository))
					}
				} label: { EmptyView() }
			}
			.animation(.default, value: viewModel.favorites)
			.task {
				await viewModel.subscribeToData()
			}
    }
	
	// MARK: - ViewModel.
	
	final class ViewModel: ObservableObject {
		
		/// Data source.
		@Published private(set) var favorites: [ItunesItem]
			
		// 🔵 Chapter 5 hands on: something missing from here?!
		
		/// Provides data and interacts with it.
		let favoritesRepository: FavoritesRepository
		
		/// Holds the subscription to
		private var dataSourceSubscription: AnyCancellable?
		
		// MARK: - Init.
		
		init(favoritesRepository: FavoritesRepository) {
			self.favorites = []
			self.favoritesRepository = favoritesRepository
		}
		
		// MARK: - Public interface.
		
		/// Attaches itself to repository provided data.
		func subscribeToData() async {
			self.dataSourceSubscription = await favoritesRepository.favoritesPublisher
				.receive(on: RunLoop.main)
				.sink { [weak self] in
					self?.favorites = $0
				}
		}
		
		/// What happens when the user taps on an `item`.
		/// - Parameter item: Data source.
		func itemAction(item: ItunesItem) {
			// 🔵 Chapter 5 hands on: insert the relevant code here..
		}
		
		/// What happens when the user taps on the CTA on the empty state.
		func emptyListAction() {
			// 🔵 Chapter 5 hands on: insert the relevant code here..
		}
		
		/// Removes the `ItunesItem` from the list of favorited data.
		/// - Parameter item: Data source.
		func removeFromFavoritesAction(indexSet: IndexSet) {
			// Determine which elements have been deleted.
			var copy = favorites
			copy.remove(atOffsets: indexSet)
			let diff = Set(favorites).subtracting(copy)
			
			// Delete all the specific elements so that we don't reference them by id.
			diff.forEach { item in
				Task {
					await favoritesRepository.removeFromFavorites(itemWithId: item.id)
				}
			}
		}
	}
}

struct FavoritesContentView: View {
	/// Helps with scoping the localization for this context only.
	typealias Strings = L10n.Favorites
	
	/// Data source.
	let items: [ItunesItem]
	
	/// What happens when the user interacts with an `ItunesItem`.
	var itemAction: (ItunesItem) -> Void = { _ in }
	
	/// What happens when the user wants to interact with the favorites.
	var favoriteAction: (IndexSet) -> Void = { _ in }
	
	/// When happens when the user taps on the CTA from the empty state.
	var emptyAction: () -> Void = { }
	
	// MARK: - Body.
	
	var body: some View {
		favoritesList
			.overlay {
				noFavoritesView
					.opacity(items.isEmpty ? 1.0 : 0.0)
			}
	}
	
	/// List of `favorited items`.
	private var favoritesList: some View {
		List {
			ForEach(items) { item in
				ResultCell(item: item, trailingDecoration: {
					Image(systemName: "star.fill")
						.foregroundColor(Color(asset: Asset.Colors.mandarinJelly))
				})
					.onTapGesture {
						itemAction(item)
					}
					// Allow long-press on the item and interaction with it.
					.contextMenu {
						Button(item.title ?? "") {
							itemAction(item)
						}
					} preview: {
						itemPreview(item)
					}
			}
			.onDelete { indexSet in
				favoriteAction(indexSet)
			}
		}
		.listStyle(.plain)
		.toolbar { EditButton() }
	}
	
	/// Contains some small description of why there is no data visible.
	private var noFavoritesView: some View {
		VStack {
			Image(asset: Asset.Assets.empyBox)
			Text(Strings.Empty.title)
				.headlineStyle()
			Text(Strings.Empty.body)
				.bodyStyle()
				.multilineTextAlignment(.center)
			Button(action: emptyAction, label: { Text(Strings.Empty.cta) })
				.padding(.top, 10.0)
				.tint(Color.Text.quaternary)
		}
	}
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
		FavoritesContentView(items: [])
    }
}
