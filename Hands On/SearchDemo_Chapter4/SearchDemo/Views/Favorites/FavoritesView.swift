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
	
	// 🔵 Chapter 4 hands on: we can definitely find a better solution..
	@State private var selectedItem: ItunesItem?
	@EnvironmentObject private var favoritesRepository: FavoritesRepository
	
	// MARK: - Body.
	
    var body: some View {
		FavoritesContentView(
			items: [],
			itemAction: { selectedItem = $0 },
			favoriteAction: { _ in },
			emptyAction: { } // Don't bother with this for now..
		)
			.background {
				NavigationLink(isActive: Binding(get: { selectedItem != nil }, set: { _ in selectedItem = nil })) {
					if let selectedItem {
						DetailView(viewModel: DetailView.ViewModel.init(item: selectedItem, favoritesRepository: favoritesRepository))
					}
				} label: { EmptyView() }
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
