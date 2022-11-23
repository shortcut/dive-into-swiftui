//
//  ItemOfTheDayView.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI
import ItunesApi

struct ItemOfTheDayView: View {
	
	/// Handles fetching the resource required for the item of the day.
	@StateObject private var viewModel: ViewModel = .init()
	
	/// `true` for when the details should be presented on the screen.
	@State var shouldPresentItemDetails: Bool = false
		
	// MARK: - Body.
	
    var body: some View {
		NavigationView {
			ZStack {
				if shouldPresentItemDetails, let item = viewModel.itemOfTheDay, let posterImage = viewModel.posterImage {
					detailsView(item: item, image: posterImage)
				} else {
					homeView
				}
			}
			.navigationTitle(L10n.ItemOfTheDay.title)
			.animation(.default, value: shouldPresentItemDetails)
		}
    }
	
	/// The home `State` of the `ItemOfTheDay View`.
	private var homeView: some View {
		VStack {
			poster
				.onTapGesture { shouldPresentItemDetails = true }
			Text(viewModel.itemOfTheDay?.title ?? "")
				.font(.title2)
			Text(viewModel.itemOfTheDay?.artistName ?? "")
				.bodyStyle()
		}
	}
	
	/// The details `State` of the `ItemOfTheDay View`.
	/// - Parameters:
	///   - item: Data source.
	///   - image: Required so that the transition from home -> details does not trigger an async load of the image.
	private func detailsView(item: ItunesItem, image: UIImage) -> some View {
		// This is where your magic comes into action.
		EmptyView()
	}
	
	/// Visual artwork of the `ItunesItem`.
	@ViewBuilder private var poster: some View {
		if let posterImage = viewModel.posterImage {
			Image(uiImage: posterImage)
				.resizable()
				.scaledToFit()
				.cornerRadius(25.0)
				.frame(width: 300.0, height: 300.0)
		} else {
			ProgressView()
				.scaleEffect(3.0)
				.task { await viewModel.fetchPosterImage() }
		}
	}
	
	// MARK: - ViewModel.
	
	private final class ViewModel: ObservableObject {
		
		/// All the data source.
		private lazy var results: [ItunesItem] = {
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
		
		/// Required so that it can be reused in the detailed view.
		@Published private(set) var posterImage: UIImage?
		
		/// Current data source.
		lazy var itemOfTheDay: ItunesItem? = results.randomElement()
		
		/// Fetches the artwork associated with the `ItunesItem` of the day and saves it for reusage.
		@MainActor func fetchPosterImage() async {
			guard let url = itemOfTheDay?.artwork(size: 600) else { return }
			do {
				let (imageData, _) = try await URLSession.shared.data(for: URLRequest(url: url))
				self.posterImage = UIImage(data: imageData)
			} catch { }
		}
	}
}

/// Uniquely identifies different elements that we want to animate from and to using `.matchedGeometryEffect API`.
enum DetailsAnimationIdentifiers: String, Hashable {
	case title, background, poster
}

struct ItemOfTheDayView_Previews: PreviewProvider {
    static var previews: some View {
        ItemOfTheDayView()
    }
}
