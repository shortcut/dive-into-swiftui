//
//  CollectionSection.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI
import ItunesApi

struct CollectionSection: View {
    private typealias Strings = L10n.Detail.Collection

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
            Text(L10n.Detail.Collection.title)
                .font(.title3)

            InfoLabel(label: Strings.artistName,
                      content: model.artistName)
            InfoLabel(label: Strings.name,
                      content: model.name)
            InfoLabel(label: Strings.censoredName,
                      content: model.censoredName)
            InfoLabel(label: Strings.explicitness,
                      content: model.explicitness)
            InfoLabel(label: Strings.trackCount,
                      content: model.trackCount)
            priceViews
                .environment(\.locale, model.priceLocale ?? locale)
        }
    }

    @ViewBuilder private var priceViews: some View {
        InfoLabel(label: Strings.Price.sd,
                  content: model.price)
        InfoLabel(label: Strings.Price.hd,
                  content: model.hdPrice)
    }
}

private extension CollectionSection {
    struct Model {
        let name: String?
        let censoredName: String?
        let artistName: String?
        let explicitness: String?
        let trackCount: String?
        let priceLocale: Locale?
        let price: String?
        let hdPrice: String?

        init?(item: ItunesItem) {
            name = item.wrapperType != .collection ? item.collectionName : nil

            censoredName = item.collectionCensoredName != item.collectionName ? item.collectionCensoredName : nil

            artistName = item.collectionArtistName

            explicitness = item.collectionExplicitness?.description

            trackCount = item.trackCount.map(IntegerFormatStyle.number.format)

            priceLocale = item.priceLocale

            price = item.formattedCollectionPrice

            hdPrice = item.formattedCollectionHDPrice

            guard !allFieldsAreEmpty else { return nil }
        }

        private var allFieldsAreEmpty: Bool {
            [
                name,
                censoredName,
                artistName,
                explicitness,
                trackCount,
                price,
                hdPrice
            ].compactMap {
                $0
            }.isEmpty
        }
    }
}

extension ItunesItem {
    var formattedCollectionPrice: String? {
        guard let currency,
              let collectionPrice,
              collectionPrice > 0
        else { return nil }
        return FloatingPointFormatStyle
            .Currency(code: currency)
            .format(collectionPrice)
    }

    var formattedCollectionHDPrice: String? {
        guard let currency,
              let collectionHdPrice,
              collectionHdPrice > 0,
              collectionHdPrice != collectionPrice
        else { return nil }
        return FloatingPointFormatStyle
            .Currency(code: currency)
            .format(collectionHdPrice)
    }
}

struct CollectionSection_Previews: PreviewProvider {
    static var previews: some View {
        CollectionSection(item: RootView_Previews.firstItem)
            .padding()
            .previewLayout(.sizeThatFits)
            .environment(\.infoLabelWidth, 100)
    }
}
