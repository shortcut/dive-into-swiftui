//
//  ResultCell.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI
import ItunesApi

struct ResultCell<Decoration: View>: View {
    
	/// Data source.
	let item: ItunesItem
	
	/// Item added on the trailing edge of the cell.
	let trailingDecoration: Decoration
	
	// MARK: - Init.
	
	init(item: ItunesItem) where Decoration == EmptyView {
		self.item = item
		self.trailingDecoration = EmptyView()
	}
	
	init(item: ItunesItem, @ViewBuilder trailingDecoration: () -> Decoration) {
		self.item = item
		self.trailingDecoration = trailingDecoration()
	}
	
	// MARK: - Body.

    var body: some View {
		HStack(spacing: 10.0) {
            image
                .frame(width: 100, height: 100)
            VStack(alignment: .leading) {
                if let title = item.title {
                    Text(title)
						.headlineStyle()
                }
                if let detail = item.detail {
                    Text(detail)
						.bodyStyle()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
			trailingDecoration
        }
    }

    @ViewBuilder private var image: some View {
        if let url = item.artworkUrl100.flatMap(URL.init(string:)) {
            AsyncImage(url: url) { image in
                SquareImage(image: image)
					.clipShape(RoundedRectangle(cornerRadius: 9.0))
					.shadow(radius: 5.0)
            } placeholder: {
                ProgressView()
            }
        } else {
            Image(systemName: "photo.artframe")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.accentColor)
        }
    }
}

struct ResultCell_Previews: PreviewProvider {
    static var previews: some View {
        ResultCell(item: RootView_Previews.firstItem)
        .previewLayout(.sizeThatFits)
    }
}
