//
//  TrackSection.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI
import ItunesApi

struct TrackSection: View {
    fileprivate typealias Strings = L10n.Detail.Track

    private let model: Model

    @Environment(\.locale) private var locale

    init?(item: ItunesItem) {
        guard let model = Model(item: item) else {
            return nil
        }
        self.model = model
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(Strings.title)
                .font(.title3)
            InfoLabel(label: Strings.name,
                      content: model.name)
            InfoLabel(label: Strings.trackCensoredName,
                      content: model.censoredName)
            InfoLabel(label: Strings.explicitness,
                      content: model.explicitness)
            InfoLabel(label: Strings.contentRating,
                      content: model.contentRating)
            InfoLabel(label: Strings.time,
                      content: model.runLength)
            priceViews
                .environment(\.locale, model.locale ??  locale)

            InfoLabel(label: Strings.position,
                      content: model.albumPosition)
        }
    }

    @ViewBuilder private var priceViews: some View {
        InfoLabel(label: Strings.Price.sd,
                  content: model.price)
        InfoLabel(label: Strings.Price.hd,
                  content: model.hdPrice)
        InfoLabel(label: Strings.Price.Rental.sd,
                  content: model.rentalPrice)
        InfoLabel(label: Strings.Price.Rental.hd,
                  content: model.hdRentalPrice)
    }
}

private extension TrackSection {

    struct Model {
        let name: String?
        let censoredName: String?
        let contentRating: String?
        let explicitness: String?
        let albumPosition: String?
        let runLength: String?
        let price: String?
        let hdPrice: String?
        let rentalPrice: String?
        let hdRentalPrice: String?
        let locale: Locale?

        init?(item: ItunesItem) {
            name = item.wrapperType == .track ? nil : item.trackName
            censoredName = item.trackCensoredName != item.trackName ? item.trackCensoredName : nil
            contentRating = item.trackContentRating
            albumPosition = item.formattedAlbumPosition

            explicitness = item.trackExplicitness?.description

            price = item.formattedTrackPrice
            hdPrice = item.formattedHDTrackPrice
            rentalPrice = item.formattedTrackRentalPrice
            hdRentalPrice = item.formattedHDTrackRentalPrice

            runLength = item.runLength
            locale = item.priceLocale

            guard !allFieldsAreEmpty else { return nil }
        }

        var allFieldsAreEmpty: Bool {
            [
                name,
                censoredName,
                contentRating,
                explicitness,
                albumPosition,
                price,
                hdPrice,
                rentalPrice,
                hdRentalPrice,
                runLength
            ].compactMap {
                $0
            }.isEmpty
        }
    }
}

private extension ItunesItem {
    var formattedAlbumPosition: String? {
        guard let trackNumber, let trackCount else { return nil }
        return L10n.Detail.General.discFormat(trackNumber, trackCount)
    }

    var runLength: String? {
        trackTimeMillis
            .map { duration in
                let start = Date(timeIntervalSinceReferenceDate: 0)
                let end = Date(timeIntervalSinceReferenceDate: TimeInterval(duration) / 1_000)
                return start..<end
            }
            .map(Date.ComponentsFormatStyle.timeDuration.format)
    }

    var formattedTrackPrice: String? {
        guard let currency,
              let trackPrice,
              trackPrice > 0
        else { return nil }
        return FloatingPointFormatStyle.Currency.init(code: currency).format(trackPrice)
    }

    var formattedHDTrackPrice: String? {
        guard let currency,
              let trackHdPrice,
              trackHdPrice > 0,
              trackHdPrice != trackPrice
        else { return nil }
        return FloatingPointFormatStyle.Currency.init(code: currency).format(trackHdPrice)
    }

    var formattedTrackRentalPrice: String? {
        guard let currency,
              let trackRentalPrice,
              trackRentalPrice > 0
        else { return nil }
        return FloatingPointFormatStyle.Currency.init(code: currency).format(trackRentalPrice)
    }

    var formattedHDTrackRentalPrice: String? {
        guard let currency,
              let trackHdRentalPrice,
              trackHdRentalPrice > 0,
              trackHdRentalPrice != trackHdRentalPrice
        else { return nil }
        return FloatingPointFormatStyle.Currency.init(code: currency).format(trackHdRentalPrice)
    }
}

struct TrackSection_Previews: PreviewProvider {
    static var previews: some View {
        TrackSection(item: RootView_Previews.firstItem)?
            .environment(\.infoLabelWidth, 100)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
