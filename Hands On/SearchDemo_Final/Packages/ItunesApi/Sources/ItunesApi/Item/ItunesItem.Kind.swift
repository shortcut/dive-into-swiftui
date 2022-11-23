//
//  ItunesItem.Kind.swift
//  Art Thief
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//  Copyright © 2019 Atelier Clockwork. All rights reserved.
//

import Foundation

extension ItunesItem {
    public enum Kind: String, Codable, CustomStringConvertible, Hashable {
        case album
        case artist
        case book
        case coachedAudio = "coached-audio"
        case ebook
        case featureMovie = "feature-movie"
        case interactiveBooklet = "interactive-booklet"
        case musicVideo = "music-video"
        case pdf
        case podcast
        case podcastEpisode = "podcast-episode"
        case software = "software"
        case softwarePackage = "software-package"
        case song
        case tvEpisode = "tv-episode"

        public var description: String {
            switch self {
            case .album: return L10n.Result.Kind.album
            case .artist: return L10n.Result.Kind.artist
            case .book: return L10n.Result.Kind.book
            case .coachedAudio: return L10n.Result.Kind.coachedAudio
            case .ebook: return L10n.Result.Kind.ebook
            case .featureMovie: return L10n.Result.Kind.featureMovie
            case .interactiveBooklet: return L10n.Result.Kind.interactiveBooklet
            case .musicVideo: return L10n.Result.Kind.musicVideo
            case .pdf: return L10n.Result.Kind.pdf
            case .podcast: return L10n.Result.Kind.podcast
            case .podcastEpisode: return L10n.Result.Kind.podcastEpisode
            case .software: return L10n.Result.Kind.software
            case .softwarePackage: return L10n.Result.Kind.softwarePackage
            case .song: return L10n.Result.Kind.song
            case .tvEpisode: return L10n.Result.Kind.tvEpisode
            }
        }
    }
}
