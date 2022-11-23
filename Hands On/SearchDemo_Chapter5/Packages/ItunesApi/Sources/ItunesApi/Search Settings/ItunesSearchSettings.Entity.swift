//
//  ItunesSearchSettings.Entity.swift
//  Art Thief
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//  Copyright © 2019 Atelier Clockwork. All rights reserved.
//

import Foundation

public extension ItunesSearchQuery {
    enum Entity: String, Hashable, Identifiable, Codable {
        public var id: Self {
            return self
        }

        case none
        case movieArtist
        case movie
        case podcastAuthor
        case podcast
        case musicArtist
        case musicTrack
        case album
        case musicVideo
        case mix
        case song
        case audiobookAuthor
        case audiobook
        case shortFilmArtist
        case shortFilm
        case tvEpisode
        case tvSeason
        case software
        case iPadSoftware
        case macSoftware
        case ebook
        case allArtist
        case allTrack
    }
}

extension ItunesSearchQuery.Entity: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none: return L10n.Media.Entity.none
        case .movieArtist: return L10n.Media.Entity.movieArtist
        case .movie: return L10n.Media.Entity.movie
        case .podcastAuthor: return L10n.Media.Entity.podcastAuthor
        case .podcast: return L10n.Media.Entity.podcast
        case .musicArtist: return L10n.Media.Entity.musicArtist
        case .musicTrack: return L10n.Media.Entity.musicTrack
        case .album: return L10n.Media.Entity.album
        case .musicVideo: return L10n.Media.Entity.musicVideo
        case .mix: return L10n.Media.Entity.mix
        case .song: return L10n.Media.Entity.song
        case .audiobookAuthor: return L10n.Media.Entity.audiobookAuthor
        case .audiobook: return L10n.Media.Entity.audiobook
        case .shortFilmArtist: return L10n.Media.Entity.shortFilmArtist
        case .shortFilm: return L10n.Media.Entity.shortFilm
        case .tvEpisode: return L10n.Media.Entity.tvEpisode
        case .tvSeason: return L10n.Media.Entity.tvSeason
        case .software: return L10n.Media.Entity.software
        case .iPadSoftware: return L10n.Media.Entity.iPadSoftware
        case .macSoftware: return L10n.Media.Entity.macSoftware
        case .ebook: return L10n.Media.Entity.ebook
        case .allArtist: return L10n.Media.Entity.allArtist
        case .allTrack: return L10n.Media.Entity.allTrack
        }
    }
}
