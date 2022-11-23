//
//  DetailView.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI
import Combine
import ItunesApi

struct DetailView: View {
	
	/// Handles navigation.
	@StateObject var viewModel: ViewModel

	// MARK: - Body.
	
	var body: some View {
		DetailContentView(item: viewModel.item)
			.task { await viewModel.setupSubscriptions() }
			.toolbar { favoriteButton }
	}

	// MARK: - Helpers.
	
	/// Settings `toolbar item`.
	private var favoriteButton: ToolbarItem<Void, some View> {
		ToolbarItem(placement: .navigationBarTrailing) {
			Button {
				viewModel.favoriteAction()
			} label: {
				Label(L10n.Search.Toolbar.settings, systemImage: viewModel.isFavorited == true ? "star.fill" : "star")
			}
			.disabled(viewModel.isFavorited == nil)
		}
	}
	
	// MARK: - ViewModel.
	
	final class ViewModel: ObservableObject {
		
		/// `true` if the `Item` is part of the favorites list.
		@Published private(set) var isFavorited: Bool?
		
		/// Data source.
		let item: ItunesItem
		
		/// Provides information `favorites` related information.
		private let favoritesRepository: FavoritesRepository
		
		// 🔵 Chapter 5 hands on: something missing from here?!
		
		/// Holds the subscription to the `isFavoritedPublisher` alive.
		private var favoriteSubscription: AnyCancellable?
		
		// MARK: - Init
		
		init(item: ItunesItem, favoritesRepository: FavoritesRepository) {
			self.item = item
			self.favoritesRepository = favoritesRepository
		}
		
		// MARK: - Public interface.
		
		/// Binds the data to remote sources.
		func setupSubscriptions() async {
			favoriteSubscription = await favoritesRepository.isFavoritedPublisher(itemId: item.id)
				.receive(on: RunLoop.main)
				.sink { [weak self] in
					self?.isFavorited = $0
				}
		}
		
		/// Called when the user interacts with the posters of an `ItunesItem`.
		/// - Parameter url: Where the resource can be found.
		func posterAction(url: URL) {
			// 🔵 Chapter 5 hands on: insert the relevant code here..
		}
		
		/// Called when the user interacts with the favorited state of the `ItunesItem`.
		/// - Parameter item: Data source.
		func favoriteAction() {
			Task { @MainActor in
				await favoritesRepository.toggleInFavorites(item: item)
			}
		}
	}
}

struct DetailContentView: View {
	
	/// Helps with scoping the localization for this context only.
	typealias Strings = L10n.Detail
	
	/// Helps defining a space relative to which we can compute distances
	/// for the parallax effect.
	private let coordinateSpace = "Detail"
	
	/// Used to align all the section labels so that the descriptions start at the same offset.
	@State private var labelWidth: CGFloat?
	
	/// Data source.
	let item: ItunesItem
	
	/// Called when the user interacts with the posters of an `ItunesItem`.
	var posterAction : (URL) -> Void = { _ in }
	
	// MARK: - Body.
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 20) {
				if let url = item.artwork(size: 600) {
					imageView(for: url)
						.scrollViewHeader(effects: [.parallax, .grow],
										  coordinateSpace: CoordinateSpace.named(coordinateSpace))
				}
				itemSections
					.padding(.horizontal)
			}
		}
		.coordinateSpace(name: coordinateSpace)
		.navigationBarTitleDisplayMode(.inline)
		.environment(\.infoLabelWidth, labelWidth)
		.onPreferenceChange(InfoLabelWidthKey.self) { width in
			labelWidth = width
		}
	}

	@ViewBuilder private var itemSections: some View {
		GeneralSection(item: item)
		switch item.wrapperType {
		case .track:
			TrackSection(item: item)
			CollectionSection(item: item)
		case .collection:
			CollectionSection(item: item)
		case .none:
			EmptyView()
		case .artist:
			EmptyView()
		case .audiobook:
			TrackSection(item: item)
		case .software:
			TrackSection(item: item)
		}
		ImageSection(label: Strings.Screenshots.standard,
					 imageUrls: item.screenshotUrls,
					 imageAction: posterAction)
		ImageSection(label: Strings.Screenshots.iPad,
					 imageUrls: item.ipadScreenshotUrls,
					 imageAction: posterAction)
		ImageSection(label: Strings.Screenshots.appleTv,
					 imageUrls: item.appletvScreenshotUrls,
					 imageAction: posterAction)
	}

	private func imageView(for url: URL) -> some View {
		AsyncImage(url: url, scale: 2) { image in
			poster(forImage: image)
		} placeholder: {
			Color.clear
				.aspectRatio(1, contentMode: .fit)
				.overlay {
					ProgressView()
				}
		}
	}
	
	private func poster(forImage image: Image) -> some View {
		SquareImage(image: image)
	}
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
			DetailContentView(item: RootView_Previews.firstItem)
        }
    }
}
