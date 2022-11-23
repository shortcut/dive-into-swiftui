//
//  ItunesItem.swift
//  Art Thief
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//  Copyright © 2019 Atelier Clockwork. All rights reserved.
//

import Foundation

public struct ItunesItem: Codable, Hashable, Identifiable {
    public var id: Self {
        self
    }
    public let advisories: [String]?
    public let amgArtistId: Int?
    public let appletvScreenshotUrls: [URL]?
    public let artistId: Int?
    public let artistIds: [Int]?
    public let artistName: String?
    public let artistViewUrl: URL?
    public let artworkUrl100: String?
    public let artworkUrl30: String?
    public let artworkUrl512: String?
    public let artworkUrl600: String?
    public let artworkUrl60: String?
    public let averageUserRating: Float?
    public let averageUserRatingForCurrentVersion: Float?
    public let bundleId: String?
    public let collectionArtistId: Int?
    public let collectionArtistName: String?
    public let collectionArtistViewUrl: URL?
    public let collectionCensoredName: String?
    public let collectionExplicitness: ItunesItem.Explicitness?
    public let collectionHdPrice: Float?
    public let collectionId: Int?
    public let collectionName: String?
    public let collectionPrice: Float?
    public let collectionViewUrl: URL?
    public let contentAdvisoryRating: String?
    public let copyright: String?
    public let country: String?
    public let currency: String?
    public let currentVersionReleaseDate: Date?
    public let description: String?
    public let discCount: Int?
    public let discNumber: Int?
    public let features: [String]?
    public let feedUrl: URL?
    public let fileSizeBytes: FileSize?
    public let formattedPrice: String?
    public let genreIds: [String]?
    public let genres: [String]?
    public let hasITunesExtras: Bool?
    public let ipadScreenshotUrls: [URL]?
    public let isGameCenterEnabled: Bool?
    public let isStreamable: Bool?
    public let isVppDeviceBasedLicensingEnabled: Bool?
    public let kind: Kind?
    public let languageCodesISO2A: [String]?
    public let longDescription: String?
    public let minimumOsVersion: String?
    public let previewUrl: URL?
    public let price: Float?
    public let primaryGenreId: Int?
    public let primaryGenreName: String?
    public let releaseDate: Date?
    public let releaseNotes: String?
    public let screenshotUrls: [URL]?
    public let sellerName: String?
    public let sellerUrl: URL?
    public let shortDescription: String?
    public let supportedDevices: [String]?
    public let trackCensoredName: String?
    public let trackContentRating: String?
    public let trackCount: Int?
    public let trackExplicitness: Explicitness?
    public let trackHdPrice: Float?
    public let trackHdRentalPrice: Float?
    public let trackId: Int?
    public let trackName: String?
    public let trackNumber: Int?
    public let trackPrice: Float?
    public let trackRentalPrice: Float?
    public let trackTimeMillis: Int?
    public let trackViewUrl: URL?
    public let userRatingCount: Int?
    public let userRatingCountForCurrentVersion: Int?
    public let version: String?
    public let wrapperType: ItunesItem.WrapperType?
}

public extension ItunesItem {
    func artwork(size: Int) -> URL? {
        guard let range = artworkUrl100?.range(of: "100x100", options: .backwards, range: nil, locale: nil) else {
            return nil
        }
        let artwork = artworkUrl100?.replacingCharacters(in: range, with: "\(size)x\(size)")
        return artwork.flatMap(URL.init(string:))
    }
}

public extension ItunesItem {
    var title: String? {
        let title: String?
        switch wrapperType {
        case .artist?:
            title = artistName
        case .collection?, .audiobook?:
            title = collectionCensoredName
        case .track?, .software?, nil:
            title = trackName
        }
        return title
    }

    var detail: String? {
        let detail: String?
        switch wrapperType {
        case .artist?:
            detail = nil
        case .collection?, .audiobook?:
            detail = artistName
        case .track?, .software?, nil:
            detail = collectionCensoredName ?? artistName
        }
        return detail
    }
}
