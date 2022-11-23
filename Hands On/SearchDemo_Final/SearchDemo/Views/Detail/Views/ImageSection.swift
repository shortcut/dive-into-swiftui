//
//  ImageSection.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI

struct ImageSection: View {
	
	/// Short description about what the images represent.
    let label: String
	
	/// Data source.
    let imageUrls: [URL]

	/// Should be called when user interacts with a poster `URL.
	let imageAction: (URL) -> Void

	// MARK: - Init.
	
	init?(label: String, imageUrls: [URL]?, imageAction: @escaping (URL) -> Void = { _ in }) {
        guard let imageUrls, !imageUrls.isEmpty else { return nil }
        self.label = label
        self.imageUrls = imageUrls
        self.imageAction = imageAction
    }

	// MARK: - Body.
	
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .foregroundColor(.secondary)
                .font(.caption)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(imageUrls, id: \.self) { url in
                        Button {
							imageAction(url)
                        } label: {
                            image(url)
                        }
                    }
                }
            }
        }
    }

    private func image(_ url: URL) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Color
                .gray
                .redacted(reason: .placeholder)
                .aspectRatio(1, contentMode: .fit)
        }
        .frame(height: 100)
    }
}

struct ImageSection_Previews: PreviewProvider {
    static var previews: some View {
        ImageSection(label: "Images",
                     imageUrls: [
                        URL(string: "https://placekitten.com/200/300")!,
                        URL(string: "https://placekitten.com/300/300")!,
                        URL(string: "https://placekitten.com/500/300")!,
                        URL(string: "https://placekitten.com/400/200")!
                     ])
    }
}
