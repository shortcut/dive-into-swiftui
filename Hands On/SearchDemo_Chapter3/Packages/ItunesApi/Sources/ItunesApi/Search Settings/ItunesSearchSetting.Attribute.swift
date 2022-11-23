//
//  ItunesSearchSetting.Attribute.swift
//  Art Thief
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//  Copyright © 2019 Atelier Clockwork. All rights reserved.
//

import Foundation

public extension ItunesSearchQuery {
    enum Attribute: String, Hashable, Identifiable, Codable {
        public var id: Self {
            return self
        }

        case none
        case actorTerm
        case albumTerm
        case allArtistTerm
        case allTrackTerm
        case artistTerm
        case authorTerm
        case composerTerm
        case descriptionTerm
        case directorTerm
        case featureFilmTerm
        case genreIndex
        case keywordsTerm
        case languageTerm
        case mixTerm
        case movieArtistTerm
        case movieTerm
        case producerTerm
        case ratingIndex
        case ratingTerm
        case releaseYearTerm
        case shortFilmTerm
        case showTerm
        case softwareDeveloper
        case songTerm
        case titleTerm
        case tvEpisodeTerm
        case tvSeasonTerm
    }
}

extension ItunesSearchQuery.Attribute: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none: return L10n.Media.Attribute.none
        case .actorTerm: return L10n.Media.Attribute.actorTerm
        case .albumTerm: return L10n.Media.Attribute.albumTerm
        case .allArtistTerm: return L10n.Media.Attribute.allArtistTerm
        case .allTrackTerm: return L10n.Media.Attribute.allTrackTerm
        case .artistTerm: return L10n.Media.Attribute.artistTerm
        case .authorTerm: return L10n.Media.Attribute.authorTerm
        case .composerTerm: return L10n.Media.Attribute.composerTerm
        case .descriptionTerm: return L10n.Media.Attribute.descriptionTerm
        case .directorTerm: return L10n.Media.Attribute.directorTerm
        case .featureFilmTerm: return L10n.Media.Attribute.featureFilmTerm
        case .genreIndex: return L10n.Media.Attribute.genreIndex
        case .keywordsTerm: return L10n.Media.Attribute.keywordsTerm
        case .languageTerm: return L10n.Media.Attribute.languageTerm
        case .mixTerm: return L10n.Media.Attribute.mixTerm
        case .movieArtistTerm: return L10n.Media.Attribute.movieArtistTerm
        case .movieTerm: return L10n.Media.Attribute.movieTerm
        case .producerTerm: return L10n.Media.Attribute.producerTerm
        case .ratingIndex: return L10n.Media.Attribute.ratingIndex
        case .ratingTerm: return L10n.Media.Attribute.ratingTerm
        case .releaseYearTerm: return L10n.Media.Attribute.releaseYearTerm
        case .shortFilmTerm: return L10n.Media.Attribute.shortFilmTerm
        case .showTerm: return L10n.Media.Attribute.showTerm
        case .softwareDeveloper: return L10n.Media.Attribute.softwareDeveloper
        case .songTerm: return L10n.Media.Attribute.songTerm
        case .titleTerm: return L10n.Media.Attribute.titleTerm
        case .tvEpisodeTerm: return L10n.Media.Attribute.tvEpisodeTerm
        case .tvSeasonTerm: return L10n.Media.Attribute.tvSeasonTerm
        }
    }
}
