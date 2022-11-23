//
//  RatingView.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI

struct RatingView: View {
    let label: String
    let rating: Float
    let ratingCount: Int?

    private let maxRating = 5
    private var percentFull: CGFloat {
        return CGFloat(rating) / CGFloat(maxRating)
    }

    init?(label: String,
          rating: Float?,
          ratingCount: Int?) {
        guard let rating else { return nil }
        self.label = label
        self.rating = rating
        self.ratingCount = ratingCount
    }

    var body: some View {
        InfoLabel(label: label) {
            content
        }
    }

    private var content: some View {
        HStack {
            stars
            if let ratingCount {
                Text(L10n.Detail.General.Ratings.numberOfRatings(ratingCount))
            }
        }
    }

    private var stars: some View {
        emptyStars
            .background {
                GeometryReader { proxy in
                    filledStars
                        .mask(Rectangle()
                            .frame(width: proxy.size.width * percentFull)
                            .frame(maxWidth: .infinity, alignment: .leading))
                }
            }
    }

    private var filledStars: some View {
        HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Image(systemName: "star.fill")
            }
        }
        .foregroundColor(.yellow)
    }

    private var emptyStars: some View {
        HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Image(systemName: "star")
            }
        }
        .foregroundColor(.black)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RatingView(label: "1 of 5",
                       rating: 1,
                       ratingCount: 6)
            RatingView(label: "1.33 of 5",
                       rating: 1.33,
                       ratingCount: 4)
            RatingView(label: "2.5 of 5",
                       rating: 2.5,
                       ratingCount: 1000)
            RatingView(label: "5 of 5",
                       rating: 5,
                       ratingCount: 50)
        }
        .padding()
        .environment(\.infoLabelWidth, 100)
    }
}
