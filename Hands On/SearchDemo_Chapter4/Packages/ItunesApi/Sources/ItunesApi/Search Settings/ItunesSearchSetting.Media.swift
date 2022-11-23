//
//  ItunesSearchSetting.Media.swift
//  Art Thief
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//  Copyright © 2019 Atelier Clockwork. All rights reserved.
//

import Foundation

public extension ItunesSearchQuery {
    enum Media: String, CaseIterable, Hashable, Identifiable, Codable {
        public var id: Self {
            self
        }

        case all
        case music
        case movie
        case tvShow
        case software
        case audiobook
        case podcast
        case musicVideo
        case shortFilm
        case ebook
    }
}

extension ItunesSearchQuery.Media: CustomStringConvertible {
    public var description: String {
        switch self {
        case .all: return L10n.MediaType.all
        case .music: return L10n.MediaType.music
        case .movie: return L10n.MediaType.movie
        case .tvShow: return L10n.MediaType.tvShow
        case .software: return L10n.MediaType.software
        case .audiobook: return L10n.MediaType.audiobook
        case .podcast: return L10n.MediaType.podcast
        case .musicVideo: return L10n.MediaType.musicVideo
        case .shortFilm: return L10n.MediaType.shortFilm
        case .ebook: return L10n.MediaType.ebook
        }
    }
}

public extension ItunesSearchQuery.Media {
    var allowedEntities: [ItunesSearchQuery.Entity] {
        switch self {
        case .movie: return [.none,
                             .movieArtist,
                             .movie]
        case .podcast: return [.none,
                               .podcast,
                               .podcastAuthor]
        case .music: return [.none,
                             .musicArtist,
                             .musicTrack,
                             .album,
                             .musicVideo,
                             .mix,
                             .song]
        case .musicVideo: return [.none,
                                  .musicArtist,
                                  .musicVideo]
        case .audiobook: return [.none,
                                 .audiobookAuthor,
                                 .audiobook]
        case .shortFilm: return [.none,
                                 .shortFilmArtist,
                                 .shortFilm]
        case .tvShow: return [.none,
                              .tvEpisode,
                              .tvSeason]
        case .software: return [.none,
                                .software,
                                .iPadSoftware,
                                .macSoftware]
        case .ebook: return [.none,
                             .ebook]
        case .all: return [.none,
                           .movie,
                           .album,
                           .allArtist,
                           .podcast,
                           .musicVideo,
                           .mix,
                           .audiobook,
                           .tvSeason,
                           .allTrack]
        }
    }

    var allowedAttributes: [ItunesSearchQuery.Attribute] {
        switch self {
        case .all: return Self.allAllowedAttributes
        case .audiobook: return Self.audiobookAllowedAttributes
        case .ebook: return []
        case .movie: return Self.movieAllowedAttributes
        case .music: return Self.musicAllowedAttributes
        case .musicVideo: return Self.musicVideoAllowedAttributes
        case .podcast: return Self.podcastAllowedAttributes
        case .shortFilm: return Self.shortFilmAllowedAttributes
        case .software: return [.none, .softwareDeveloper]
        case .tvShow: return Self.tvShowAllowedAttributes
        }
    }
}

private extension ItunesSearchQuery.Media {
    static let allAllowedAttributes: [ItunesSearchQuery.Attribute] = [
        .none,
        .actorTerm,
        .languageTerm,
        .allArtistTerm,
        .tvEpisodeTerm,
        .shortFilmTerm,
        .directorTerm,
        .releaseYearTerm,
        .titleTerm,
        .featureFilmTerm,
        .ratingIndex,
        .keywordsTerm,
        .descriptionTerm,
        .authorTerm,
        .genreIndex,
        .mixTerm,
        .allTrackTerm,
        .artistTerm,
        .composerTerm,
        .tvSeasonTerm,
        .producerTerm,
        .ratingTerm,
        .songTerm,
        .movieArtistTerm,
        .showTerm,
        .movieTerm,
        .albumTerm
    ]

    static let audiobookAllowedAttributes: [ItunesSearchQuery.Attribute] = [
        .none,
        .titleTerm,
        .authorTerm,
        .genreIndex,
        .ratingIndex
    ]

    static let movieAllowedAttributes: [ItunesSearchQuery.Attribute] = [
        .none,
        .actorTerm,
        .genreIndex,
        .artistTerm,
        .shortFilmTerm,
        .producerTerm,
        .ratingTerm,
        .directorTerm,
        .releaseYearTerm,
        .featureFilmTerm,
        .movieArtistTerm,
        .movieTerm,
        .ratingIndex,
        .descriptionTerm
    ]

    static let musicAllowedAttributes: [ItunesSearchQuery.Attribute] = [
        .none,
        .mixTerm,
        .genreIndex,
        .artistTerm,
        .composerTerm,
        .albumTerm,
        .ratingIndex,
        .songTerm
    ]

    static let musicVideoAllowedAttributes: [ItunesSearchQuery.Attribute] = [
        .none,
        .genreIndex,
        .artistTerm,
        .albumTerm,
        .ratingIndex,
        .songTerm
    ]

    static let podcastAllowedAttributes: [ItunesSearchQuery.Attribute] = [
        .none,
        .titleTerm,
        .languageTerm,
        .authorTerm,
        .genreIndex,
        .artistTerm,
        .ratingIndex,
        .keywordsTerm,
        .descriptionTerm
    ]

    static let shortFilmAllowedAttributes: [ItunesSearchQuery.Attribute] = [
        .none,
        .genreIndex,
        .artistTerm,
        .shortFilmTerm,
        .ratingIndex,
        .descriptionTerm
    ]

    static let tvShowAllowedAttributes: [ItunesSearchQuery.Attribute] = [
        .none,
        .genreIndex,
        .tvEpisodeTerm,
        .showTerm,
        .tvSeasonTerm,
        .ratingIndex,
        .descriptionTerm
    ]
}
