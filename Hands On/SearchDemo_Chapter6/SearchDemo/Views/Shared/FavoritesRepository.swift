//
//  FavoritesRepository.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI
import Foundation
import ItunesApi
import Combine

actor FavoritesRepository {
	
	/// Used to control when and what data is exposed.
	@Published private var favorites: [ItunesItem] = []
	
	/// Publishes values whenever the user adds/ removes itunes items from his favorites.
	var favoritesPublisher: some Publisher<[ItunesItem], Never> {
		$favorites
	}
	
	/// Saved favorites values.
	@AppStorage("currentFavorites") private static var storedFavorites: Data?
	
	/// Holds the subscription of the favorites alive.
	private var updateSubscription: AnyCancellable?
	
	/// Manages how the favorites are stored locally for persistence.
	private let localStorage: FavoritesLocalStorage
	
	// MARK: - Init.
	
	init() {
		self.localStorage = .init()
		Task { await setupLocalPersistence() }
	}
	
	// MARK: - Public interface.
	
	/// Publishes values that determine whether an `item` is part of the `favorites list` or not.
	/// - Parameter itemId: Uniquely identifies an `ItunesItem`.
	func isFavoritedPublisher(itemId: ItunesItem.ID) -> some Publisher<Bool, Never> {
		$favorites
			.map { $0.contains(where: { $0.id == itemId }) }
			.removeDuplicates()
	}
	
	/// Adds the particular `ItunesItem` to the local favorites.
	/// - Parameter item: Data source.
	func addToFavorites(_ item: ItunesItem) {
		favorites.append(item)
	}
	
	/// Removes the `ItunesItem` from local favorites.
	/// - Parameter itemWithId: Uniquely identifies an `ItunesItem`.
	func removeFromFavorites(itemWithId: ItunesItem.ID) {
		favorites.removeAll(where: { $0.id == itemWithId })
	}
	
	/// If the `item` exists in `favorites` already then it removes it.
	/// If it doesn't exist, it adds it.
	/// - Parameter item: Data source.
	func toggleInFavorites(item: ItunesItem) {
		if favorites.contains(item) {
			removeFromFavorites(itemWithId: item.id)
		} else {
			addToFavorites(item)
		}
	}
	
	// MARK: - Private interface.
	
	/// Makes sure to encode the data and store it locally as soon as it's mutated.
	private func setupLocalPersistence() async {
		favorites = await localStorage.localFavorites
		await localStorage.bindStorageTo(favoritesPublisher: favoritesPublisher)
	}
}

private actor FavoritesLocalStorage {
	
	/// Saved favorites values.
	@AppStorage("currentFavorites") private var storedFavorites: Data?
	
	/// Holds the subscription of the favorites alive.
	private var updateSubscription: AnyCancellable?
	
	/// Snapshot of the current local storage.
	var localFavorites: [ItunesItem] {
		guard let localFavorites = storedFavorites,
			  let favorites = try? JSONDecoder().decode([ItunesItem].self, from: localFavorites) else { return [] }
		return favorites
	}
	
	/// Reacts to the publisher's data events and stores in the local persistence.
	/// - Parameter favoritesPublisher: Data publisher.
	func bindStorageTo(favoritesPublisher: some Publisher<[ItunesItem], Never>) {
		updateSubscription = favoritesPublisher
			.dropFirst()
			.encode(encoder: JSONEncoder())
			.sink(receiveCompletion: { completion in
				if case .failure(let error) = completion {
					NSLog("Encoding failed: \(error.localizedDescription).")
				}
			}, receiveValue: { data in
				Task { [weak self] in
					await self?.updateFavoritesData(data)
				}
			})
	}
	
	private func updateFavoritesData(_ newFavoritesData: Data) {
		storedFavorites = newFavoritesData
	}
}
