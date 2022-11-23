//
//  SearchCoordinatorView.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import Foundation
import SwiftUI
import ItunesApi

/// Visual counterpart of the `SearchCoordinator`.
struct SearchCoordinatorView: View {
	
	// 🔵 Chapter 5 hands on: where can we get `NavigationPath` from?!
	
	// MARK: - Body.
	
	var body: some View {
		// Bind the stack to the path.
		NavigationView {
			SearchView(viewModel: SearchView.ViewModel(api: ItunesSearchService()))
				.navigationTitle(Text(L10n.Search.title))
		}
	}
}
