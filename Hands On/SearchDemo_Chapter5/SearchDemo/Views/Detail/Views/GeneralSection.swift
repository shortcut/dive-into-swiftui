//
//  GeneralSection.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import SwiftUI
import ItunesApi
import HTML2Markdown

struct GeneralSection: View {
    private typealias Strings = L10n.Detail.General

    private let model: Model

    @Environment(\.locale) private var locale

    init?(item: ItunesItem) {
        guard let model = Model(item: item) else {
            return nil
        }
        self.model = model
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let title = model.title {
                Text(title)
                    .font(.title2)
            }
            if let description = model.description {
                ClippedText(description)
            }
            if let releaseNotes = model.releaseNotes {
                VStack(alignment: .leading) {
                    Text(Strings.releaseNotes)
                        .foregroundColor(.secondary)
                        .font(.caption)
                    if let releaseInfo = model.releaseInfo {
                        Text(releaseInfo)
                            .font(.caption)

                    }
                    ClippedText(releaseNotes)
                }
            }
            VStack(alignment: .leading) {
                topGroup
                bottomGroup
            }
        }
    }

    @ViewBuilder private var topGroup: some View {
        InfoLabel(label: Strings.advisories,
                  content: model.advisories)
        InfoLabel(label: Strings.contentAdvisoryRating,
                  content: model.contentAdvisoryRating)
        InfoLabel(label: Strings.Artist.name,
                  content: model.artistName)
        InfoLabel(label: Strings.copyright,
                  content: model.copyright)
        InfoLabel(label: Strings.releaseDate,
                  content: model.releaseDate)
        if model.releaseDate == nil {
            InfoLabel(label: Strings.currentVersionReleaseDate,
                      content: model.currentVersionReleaseDate)
        }
        InfoLabel(label: Strings.discCount,
                  content: model.disc)
        InfoLabel(label: Strings.fileSize,
                  content: model.fileSize)
        InfoLabel(label: Strings.genres,
                  content: model.genres)
        InfoLabel(label: Strings.hasItunesExtras,
                  content: model.hasItunesExtras)
    }

    @ViewBuilder var bottomGroup: some View {
        InfoLabel(label: Strings.gameCenterEnabled,
                  content: model.isGameCenterEnabled)
        InfoLabel(label: Strings.isStreamable,
                  content: model.isStreamable)
        InfoLabel(label: Strings.isVppDeviceBasedLicensingEnabled,
                  content: model.isVppDeviceBasedLicensingEnabled)
        InfoLabel(label: Strings.gameCenterEnabled,
                  content: model.isGameCenterEnabled)
        InfoLabel(label: Strings.languages,
                  content: model.languages)
        InfoLabel(label: Strings.minimumOsVersion,
                  content: model.minimumOsVersion)
        InfoLabel(label: Strings.sellerName,
                  content: model.sellerName)
        InfoLabel(label: Strings.version,
                  content: model.version)
        RatingView(label: Strings.averageUserRating,
                   rating: model.userRating,
                   ratingCount: model.ratingCount)
        RatingView(label: Strings.thisVersionAverageUserRating,
                   rating: model.currentVersionUserRating,
                   ratingCount: model.currentVersionRatingCount)
    }
}

private extension GeneralSection {
    struct Model {
        let title: String?
        let description: AttributedString?
        let releaseNotes: AttributedString?
        let advisories: String?
        let contentAdvisoryRating: String?
        let artistName: String?
        let copyright: String?
        let releaseDate: String?
        let currentVersionReleaseDate: String?
        let disc: String?
        let fileSize: String?
        let genres: String?
        let hasItunesExtras: String?
        let isGameCenterEnabled: String?

        let isStreamable: String?
        let isVppDeviceBasedLicensingEnabled: String?
        let languages: String?
        let minimumOsVersion: String?
        let sellerName: String?
        let version: String?

        let ratingCount: Int?
        let userRating: Float?
        let currentVersionRatingCount: Int?
        let currentVersionUserRating: Float?

        var releaseInfo: String? {
            [version, currentVersionReleaseDate].compactMap {
                $0
            }
            .joined(separator: " - ")
        }

        init?(item: ItunesItem) {
            title = item.title
            description =  (item.longDescription ?? item.description)?
                .attributedFromHTML()
            let advisoriesString = item.advisories?.joined(separator: ", ")
            advisories = advisoriesString?.isEmpty == false ? advisoriesString : nil
            artistName = item.artistName
            contentAdvisoryRating = item.contentAdvisoryRating
            copyright = item.copyright

            let dateFormat = Date.FormatStyle(date: .abbreviated, time: .none)
            releaseDate = item.releaseDate?.formatted(dateFormat)
            currentVersionReleaseDate = item.currentVersionReleaseDate?.formatted(dateFormat)
            disc = item.formattedDisc
            fileSize = (item.fileSizeBytes?.bytes).map(ByteCountFormatStyle().format)
            genres = item.genres?.joined(separator: ", ") ?? item.primaryGenreName
            hasItunesExtras = item.hasITunesExtras?.humanReadableString
            isGameCenterEnabled = item.isGameCenterEnabled?.humanReadableString
            isStreamable = item.isStreamable?.humanReadableString
            isVppDeviceBasedLicensingEnabled = item.isVppDeviceBasedLicensingEnabled?.humanReadableString
            languages = item.languages?.joined(separator: ", ")
            minimumOsVersion = item.minimumOsVersion
            sellerName = item.sellerName
            version = item.version
            releaseNotes = item.releaseNotes?.attributedFromHTML()

            userRating = item.averageUserRating
            ratingCount = item.userRatingCount

            if item.userRatingCountForCurrentVersion == ratingCount,
               item.averageUserRatingForCurrentVersion == userRating {
                currentVersionUserRating = nil
                currentVersionRatingCount = nil
            } else {
                currentVersionUserRating = item.averageUserRatingForCurrentVersion
                currentVersionRatingCount = item.userRatingCountForCurrentVersion
            }

            guard !allFieldsAreEmpty else { return nil }
        }

        private var allFieldsAreEmpty: Bool {
            [
                description,
                releaseNotes
            ].compactMap {
                $0
            }.isEmpty
            &&
            [
                advisories,
                contentAdvisoryRating,
                artistName,
                copyright,
                releaseDate,
                currentVersionReleaseDate,
                disc,
                fileSize,
                genres,
                hasItunesExtras,
                isGameCenterEnabled,
                isStreamable,
                isVppDeviceBasedLicensingEnabled,
                languages,
                minimumOsVersion,
                sellerName,
                version
            ].compactMap {
                $0
            }.isEmpty &&
            [
                userRating,
                currentVersionUserRating
            ].compactMap {
                $0
            }.isEmpty
        }
    }
}

private extension String {
    private func markdown() throws -> String {
        let html = self
            .replacingOccurrences(of: "<b>", with: "<strong>", options: .caseInsensitive)
            .replacingOccurrences(of: "</(\\w*)b>", with: "</strong>", options: [.caseInsensitive, .regularExpression])
            .replacingOccurrences(of: "<i>", with: "<em>", options: .caseInsensitive)
            .replacingOccurrences(of: "</(\\w*)i>", with: "</em>", options: [.caseInsensitive, .regularExpression])
        let dom = try HTMLParser().parse(html: html)
        return dom.toMarkdown(options: .unorderedListBullets)
    }

    private func attributedFromMarkdown() -> AttributedString {
        do {
            return try AttributedString(
                markdown: self,
                options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)
            )
        } catch {
            return AttributedString(self)
        }
    }

    func attributedFromHTML() -> AttributedString {
        do {
            return try markdown().attributedFromMarkdown()
        } catch {
            return AttributedString(self)
        }
    }
}

private extension ItunesItem {
    var formattedDisc: String? {
        switch (discCount, discNumber) {
        case (.some(let count), .some(let number)):
            if count == 1, number == 1 {
                return nil
            } else {
                return L10n.Detail.General.discFormat(number, count)
            }
        case (.some(let number), .none):
            return number.formatted()
        case (.none, .some), (.none, .none):
            return nil
        }
    }

    var languages: [String]? {
        languageCodesISO2A?
            .compactMap(Locale.autoupdatingCurrent.localizedString(forLanguageCode:))
    }
}

private extension Bool {
    var humanReadableString: String {
        self ? L10n.HumanReadable.true : L10n.HumanReadable.false
    }
}

struct GeneralSection_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSection(item: RootView_Previews.firstItem)
            .padding()
            .environment(\.infoLabelWidth, 100)
    }
}
