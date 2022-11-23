//
//  SearchView.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI
import ItunesApi
import Combine

struct SearchView: View {
    
	/// Handles the interaction with items and `search` functionality.
	@StateObject var viewModel: ViewModel
	
	// 🔵 Chapter 5 hands on: we can definitely find a better solution..
	@EnvironmentObject private var repository: FavoritesRepository
	@State private var selectedItem: ItunesItem?
	
	// MARK: - Body.

    var body: some View {
		SearchContentView(state: viewModel.state, itemAction: { selectedItem = $0 })
			.toolbar { settingsItem }
			.searchable(text: $viewModel.query.searchTerm)
			.popover(isPresented: $viewModel.presentingSearchSettings) {
				Settings(query: $viewModel.query)
			}
			.background {
				NavigationLink(isActive: Binding(get: { selectedItem != nil }, set: { _ in selectedItem = nil })) {
					if let selectedItem {
						DetailView(viewModel: DetailView.ViewModel.init(item: selectedItem, favoritesRepository: repository))
					}
				} label: { EmptyView() }
			}
			.isLoading($viewModel.isLoading)
    }

	// MARK: - Helpers.
	
	/// Settings `toolbar item`.
	private var settingsItem: ToolbarItem<Void, some View> {
		ToolbarItem(placement: .navigationBarTrailing) {
			Button {
				viewModel.settingsAction()
			} label: {
				Label(L10n.Search.Toolbar.settings, systemImage: "gearshape")
			}
		}
	}
	
	// MARK: - ViewModel.
	
	final class ViewModel: ObservableObject {
		
		/// Each case corresponds to a different UI layout.
		enum State {
			/// The user hasn't yet performed a search yet.
			case noSearch
			
			/// We're currently displaying the user's search results.
			case results([ItunesItem])
			
			/// There are no results for user's search query.
			case noResults(query: String)
			
			/// Something has gone wrong with the query.
			case error
		}
		
		/// Defines what the `Search` is currently displaying.
		@Published var state: State = .noSearch
		
		/// What the user writes in the search field and much more.
		@Published var query = ItunesSearchQuery()

		/// Controls the visibility of the `search settings`.
		@Published var presentingSearchSettings: Bool = false
		
		/// `true` when a loading operation is in progress.
		@Published var isLoading: Bool = false
		
		// 🔵 Chapter 5 hands on: something missing from here?!
		
		/// Performs the actual search.
		private let api: ItunesSearchServiceProtocol
		
		/// Keeps the binding to the `query` alive so that so we can debounce user's input.
		private var searchCancellable: AnyCancellable?
		
		/// Previous query so that when we open the app we don't lose it.
		@AppStorage("currentQuery") var storedQuery: Data?
		
		/// The current `Task` that is fetching the data.
		private var searchTask: Task<Void, Never>? {
			didSet { oldValue?.cancel() }
		}
		
		// MARK: - Init.
		
		init(api: ItunesSearchServiceProtocol) {
			self.api = api
			
			let encoder = JSONEncoder()
			searchCancellable = $query
				// As soon as we receive data, display the loading spinner,
				.handleEvents(receiveOutput: { [weak self] in
					let shouldLoad = !$0.searchTerm.isEmpty
					if shouldLoad != self?.isLoading {
						self?.isLoading = shouldLoad
					}
				})
				.debounce(for: 0.3, scheduler: OperationQueue.main, options: nil)
				.sink { [weak self] query in
					defer { self?.isLoading = false }
					self?.performSearch(query)
					self?.storedQuery = try? encoder.encode(query)
				}
			
			let loadedQuery = storedQuery.flatMap { data in
				try? JSONDecoder().decode(ItunesSearchQuery.self, from: data)
			}
			if let loadedQuery {
				query = loadedQuery
			}
		}
		
		// MARK: - Public interface.
		
		/// To be called when the user taps/ interacts with an `ItunesItem`.
		/// - Parameter item: Data source.
		func itemAction(_ item: ItunesItem) {
			// 🔵 Chapter 5 hands on: insert the relevant code here..
		}
		
		/// To be called when the user interacts/ wants to change the `Search settings`.
		func settingsAction() {
			presentingSearchSettings = true
		}
		
		// MARK: - Private interface.
		
		/// Fetches the data.
		/// - Parameter query: What the user has typed in.
		private func performSearch(_ query: ItunesSearchQuery) {
			guard query.searchTerm.count >= 3 else { return state = .noSearch }
			searchTask = Task { @MainActor in
				do {
					let items = try await api.search(for: query)
					if items.isEmpty {
						state = .noResults(query: query.searchTerm)
					} else {
						state = .results(items)
					}
				} catch {
					state = .error
				}
			}
		}
	}
}

struct SearchContentView: View {
	/// Helps with scoping the localization for this context only.
	typealias Strings = L10n.Search
	
	/// Helps defining a space relative to which we can compute distances
	/// for the parallax effect.
	private let coordinateSpace = "SearchList"
	
	/// Unique identifier of the element at the top of the list.
	/// Required for referencing using the `ScrollViewReader proxy`.
	private let topElementId = "top_space"
	
	/// Data source.
	let state: SearchView.ViewModel.State
		
	/// What happens when the user interacts with an `ItunesItem`.
	var itemAction: (ItunesItem) -> Void = { _ in }
	
	/// Determines the visibility of the "scroll to top" view.
	@State private var showScrollToTopButton: Bool = false
	
	// MARK: - View.
	
	var body: some View {
		switch state {
		case .noSearch:
			waitingView
			
		case .results(let items):
			resultsView(items: items)
			
		case .noResults(let query):
			noResultsView(query: query)
			
		case .error:
			Text(Strings.Error.body)
				.bodyStyle()
		}
	}
	
	/// List displaying user's search results.
	/// - Parameter items: Data source.
	private func resultsView(items: [ItunesItem]) -> some View {
		ScrollViewReader { scrollProxy in
			ScrollView {
				LazyVStack {
					Color.clear
						.frame(height: 1.0)
						.id(topElementId)
					ForEach(items) { item in
						ResultCell(item: item)
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
							.padding([.horizontal])
							.padding([.vertical], 5.0)
						Divider()
					}
				}
				.readOffsetChanges(in: CoordinateSpace.named(coordinateSpace), onOffsetChange: reactToScrollChange(scrollOffset:))
			}
			.overlay(alignment: .bottom) {
				if showScrollToTopButton {
					scrollToTopButton {
						withAnimation {
							scrollProxy.scrollTo(topElementId)
						}
					}
					.transition(.move(edge: .bottom).animation(.spring()))
				}
			}
		}
	}
	
	/// Suggestive button with regards to the scroll action.
	/// - Parameter action: To be performed when interacted with the `Button`.
	private func scrollToTopButton(action: @escaping () -> Void) -> some View {
		Button(action: action) {
			Circle()
				.fill(Color(asset: Asset.Colors.mandarinJelly))
				.frame(width: 45.0, height: 45.0)
				.overlay {
					Image(systemName: "arrow.up")
						.resizable()
						.scaledToFit()
						.padding(12.0)
						.foregroundColor(.white)
				}
		}
		.padding()
	}
	
	/// Determine the visiblity of the "scroll to top" button based on how much the user has scrolled.
	/// - Parameter scrollOffset: How much the list has been scrolled.
	private func reactToScrollChange(scrollOffset: CGPoint) {
		let threshold: CGFloat = -400.0
		let shouldDisplayScrollToTopButton = scrollOffset.y < threshold
		if showScrollToTopButton != shouldDisplayScrollToTopButton {
			withAnimation { showScrollToTopButton = shouldDisplayScrollToTopButton }
		}
	}
					
	/// Contains some small description of why there is no data visible.
	private var waitingView: some View {
		VStack {
			Image(asset: Asset.Assets.empyBox)
			Text(Strings.Waiting.title)
				.headlineStyle()
			Text(Strings.Waiting.body)
				.bodyStyle()
				.multilineTextAlignment(.center)
		}
	}
	
	/// Informs the user that his search did not yield any results.
	private func noResultsView(query: String) -> some View {
		VStack {
			Image(asset: Asset.Assets.noResults)
			Text(Strings.NoResults.body(query))
				.headlineStyle()
		}
	}
}

extension View {
	
	/// The preview that the user will be presented with when long pressing on an `ItunesItem`.
	/// - Parameter item: Data source.
	func itemPreview(_ item: ItunesItem) -> some View {
		AsyncImage(url: item.artwork(size: 600)) { image in
			image
				.resizable()
				.aspectRatio(contentMode: .fit)
		} placeholder: {
			ProgressView()
				.frame(maxWidth: .infinity)
				.aspectRatio(1, contentMode: .fit)
		}
	}
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
		SearchContentView(state: .noSearch)
            .previewDisplayName("Waiting")

		SearchContentView(state: .results(RootView_Previews.results))
            .previewDisplayName("Results")

		SearchContentView(state: .noResults(query: "Hello, World!"))
            .previewDisplayName("No Results")

		SearchContentView(state: .error)
            .previewDisplayName("Error")
    }
}
