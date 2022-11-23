// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Country {
    /// Denmark
    internal static let dk = L10n.tr("Localizable", "country.dk", fallback: "Denmark")
    /// Great Britain
    internal static let gb = L10n.tr("Localizable", "country.gb", fallback: "Great Britain")
    /// Japan
    internal static let jp = L10n.tr("Localizable", "country.jp", fallback: "Japan")
    /// North Macedonia
    internal static let mk = L10n.tr("Localizable", "country.mk", fallback: "North Macedonia")
    /// Norway
    internal static let no = L10n.tr("Localizable", "country.no", fallback: "Norway")
    /// Romania
    internal static let ro = L10n.tr("Localizable", "country.ro", fallback: "Romania")
    /// Sweden
    internal static let se = L10n.tr("Localizable", "country.se", fallback: "Sweden")
    /// Ukraine
    internal static let ua = L10n.tr("Localizable", "country.ua", fallback: "Ukraine")
    /// United State
    internal static let us = L10n.tr("Localizable", "country.us", fallback: "United State")
  }
  internal enum Media {
    internal enum Attribute {
      /// Actor
      internal static let actorTerm = L10n.tr("Localizable", "media.attribute.actorTerm", fallback: "Actor")
      /// Album
      internal static let albumTerm = L10n.tr("Localizable", "media.attribute.albumTerm", fallback: "Album")
      /// Artist (all)
      internal static let allArtistTerm = L10n.tr("Localizable", "media.attribute.allArtistTerm", fallback: "Artist (all)")
      /// Track (all)
      internal static let allTrackTerm = L10n.tr("Localizable", "media.attribute.allTrackTerm", fallback: "Track (all)")
      /// Artist
      internal static let artistTerm = L10n.tr("Localizable", "media.attribute.artistTerm", fallback: "Artist")
      /// Author
      internal static let authorTerm = L10n.tr("Localizable", "media.attribute.authorTerm", fallback: "Author")
      /// Composer
      internal static let composerTerm = L10n.tr("Localizable", "media.attribute.composerTerm", fallback: "Composer")
      /// Description
      internal static let descriptionTerm = L10n.tr("Localizable", "media.attribute.descriptionTerm", fallback: "Description")
      /// Director
      internal static let directorTerm = L10n.tr("Localizable", "media.attribute.directorTerm", fallback: "Director")
      /// Feature film
      internal static let featureFilmTerm = L10n.tr("Localizable", "media.attribute.featureFilmTerm", fallback: "Feature film")
      /// Genre
      internal static let genreIndex = L10n.tr("Localizable", "media.attribute.genreIndex", fallback: "Genre")
      /// Keywords
      internal static let keywordsTerm = L10n.tr("Localizable", "media.attribute.keywordsTerm", fallback: "Keywords")
      /// Language
      internal static let languageTerm = L10n.tr("Localizable", "media.attribute.languageTerm", fallback: "Language")
      /// Mix
      internal static let mixTerm = L10n.tr("Localizable", "media.attribute.mixTerm", fallback: "Mix")
      /// Artist (movie)
      internal static let movieArtistTerm = L10n.tr("Localizable", "media.attribute.movieArtistTerm", fallback: "Artist (movie)")
      /// Movie
      internal static let movieTerm = L10n.tr("Localizable", "media.attribute.movieTerm", fallback: "Movie")
      /// None
      internal static let `none` = L10n.tr("Localizable", "media.attribute.none", fallback: "None")
      /// Producer
      internal static let producerTerm = L10n.tr("Localizable", "media.attribute.producerTerm", fallback: "Producer")
      /// Rating index
      internal static let ratingIndex = L10n.tr("Localizable", "media.attribute.ratingIndex", fallback: "Rating index")
      /// Rating
      internal static let ratingTerm = L10n.tr("Localizable", "media.attribute.ratingTerm", fallback: "Rating")
      /// Release year
      internal static let releaseYearTerm = L10n.tr("Localizable", "media.attribute.releaseYearTerm", fallback: "Release year")
      /// Short film
      internal static let shortFilmTerm = L10n.tr("Localizable", "media.attribute.shortFilmTerm", fallback: "Short film")
      /// Show
      internal static let showTerm = L10n.tr("Localizable", "media.attribute.showTerm", fallback: "Show")
      /// Developer
      internal static let softwareDeveloper = L10n.tr("Localizable", "media.attribute.softwareDeveloper", fallback: "Developer")
      /// Song
      internal static let songTerm = L10n.tr("Localizable", "media.attribute.songTerm", fallback: "Song")
      /// Title
      internal static let titleTerm = L10n.tr("Localizable", "media.attribute.titleTerm", fallback: "Title")
      /// TV episode
      internal static let tvEpisodeTerm = L10n.tr("Localizable", "media.attribute.tvEpisodeTerm", fallback: "TV episode")
      /// TV season
      internal static let tvSeasonTerm = L10n.tr("Localizable", "media.attribute.tvSeasonTerm", fallback: "TV season")
    }
    internal enum Entity {
      /// Album
      internal static let album = L10n.tr("Localizable", "media.entity.album", fallback: "Album")
      /// Artist (all)
      internal static let allArtist = L10n.tr("Localizable", "media.entity.allArtist", fallback: "Artist (all)")
      /// Track (all)
      internal static let allTrack = L10n.tr("Localizable", "media.entity.allTrack", fallback: "Track (all)")
      /// Audiobook
      internal static let audiobook = L10n.tr("Localizable", "media.entity.audiobook", fallback: "Audiobook")
      /// Author (audiobook)
      internal static let audiobookAuthor = L10n.tr("Localizable", "media.entity.audiobookAuthor", fallback: "Author (audiobook)")
      /// Book
      internal static let ebook = L10n.tr("Localizable", "media.entity.ebook", fallback: "Book")
      /// iPad apps
      internal static let iPadSoftware = L10n.tr("Localizable", "media.entity.iPadSoftware", fallback: "iPad apps")
      /// Mac apps
      internal static let macSoftware = L10n.tr("Localizable", "media.entity.macSoftware", fallback: "Mac apps")
      /// Mix
      internal static let mix = L10n.tr("Localizable", "media.entity.mix", fallback: "Mix")
      /// Movie
      internal static let movie = L10n.tr("Localizable", "media.entity.movie", fallback: "Movie")
      /// Artist (movie)
      internal static let movieArtist = L10n.tr("Localizable", "media.entity.movieArtist", fallback: "Artist (movie)")
      /// Artist (music)
      internal static let musicArtist = L10n.tr("Localizable", "media.entity.musicArtist", fallback: "Artist (music)")
      /// Track (music)
      internal static let musicTrack = L10n.tr("Localizable", "media.entity.musicTrack", fallback: "Track (music)")
      /// Music video
      internal static let musicVideo = L10n.tr("Localizable", "media.entity.musicVideo", fallback: "Music video")
      /// Localizable.strings
      ///   Art Thief
      /// 
      ///   Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
      internal static let `none` = L10n.tr("Localizable", "media.entity.none", fallback: "None")
      /// Podcast
      internal static let podcast = L10n.tr("Localizable", "media.entity.podcast", fallback: "Podcast")
      /// Author (podcast)
      internal static let podcastAuthor = L10n.tr("Localizable", "media.entity.podcastAuthor", fallback: "Author (podcast)")
      /// Short film
      internal static let shortFilm = L10n.tr("Localizable", "media.entity.shortFilm", fallback: "Short film")
      /// Artist (short film)
      internal static let shortFilmArtist = L10n.tr("Localizable", "media.entity.shortFilmArtist", fallback: "Artist (short film)")
      /// Apps
      internal static let software = L10n.tr("Localizable", "media.entity.software", fallback: "Apps")
      /// Song
      internal static let song = L10n.tr("Localizable", "media.entity.song", fallback: "Song")
      /// TV episode
      internal static let tvEpisode = L10n.tr("Localizable", "media.entity.tvEpisode", fallback: "TV episode")
      /// TV season
      internal static let tvSeason = L10n.tr("Localizable", "media.entity.tvSeason", fallback: "TV season")
    }
  }
  internal enum MediaType {
    /// All
    internal static let all = L10n.tr("Localizable", "mediaType.all", fallback: "All")
    /// Audiobooks
    internal static let audiobook = L10n.tr("Localizable", "mediaType.audiobook", fallback: "Audiobooks")
    /// Books
    internal static let ebook = L10n.tr("Localizable", "mediaType.ebook", fallback: "Books")
    /// Movies
    internal static let movie = L10n.tr("Localizable", "mediaType.movie", fallback: "Movies")
    /// Music
    internal static let music = L10n.tr("Localizable", "mediaType.music", fallback: "Music")
    /// Music Videos
    internal static let musicVideo = L10n.tr("Localizable", "mediaType.musicVideo", fallback: "Music Videos")
    /// Podcasts
    internal static let podcast = L10n.tr("Localizable", "mediaType.podcast", fallback: "Podcasts")
    /// Short films
    internal static let shortFilm = L10n.tr("Localizable", "mediaType.shortFilm", fallback: "Short films")
    /// Apps
    internal static let software = L10n.tr("Localizable", "mediaType.software", fallback: "Apps")
    /// TV shows
    internal static let tvShow = L10n.tr("Localizable", "mediaType.tvShow", fallback: "TV shows")
  }
  internal enum Result {
    internal enum Explicitness {
      /// Cleaned
      internal static let cleaned = L10n.tr("Localizable", "result.explicitness.cleaned", fallback: "Cleaned")
      /// Explicit
      internal static let explicit = L10n.tr("Localizable", "result.explicitness.explicit", fallback: "Explicit")
      /// Not explicit
      internal static let notExplicit = L10n.tr("Localizable", "result.explicitness.notExplicit", fallback: "Not explicit")
    }
    internal enum Kind {
      /// Album
      internal static let album = L10n.tr("Localizable", "result.kind.album", fallback: "Album")
      /// Artist
      internal static let artist = L10n.tr("Localizable", "result.kind.artist", fallback: "Artist")
      /// Book
      internal static let book = L10n.tr("Localizable", "result.kind.book", fallback: "Book")
      /// Coached audio
      internal static let coachedAudio = L10n.tr("Localizable", "result.kind.coachedAudio", fallback: "Coached audio")
      /// Ebook
      internal static let ebook = L10n.tr("Localizable", "result.kind.ebook", fallback: "Ebook")
      /// Feature movie
      internal static let featureMovie = L10n.tr("Localizable", "result.kind.featureMovie", fallback: "Feature movie")
      /// Interactive booklet
      internal static let interactiveBooklet = L10n.tr("Localizable", "result.kind.interactiveBooklet", fallback: "Interactive booklet")
      /// Music video
      internal static let musicVideo = L10n.tr("Localizable", "result.kind.musicVideo", fallback: "Music video")
      /// Pdf
      internal static let pdf = L10n.tr("Localizable", "result.kind.pdf", fallback: "Pdf")
      /// Podcast
      internal static let podcast = L10n.tr("Localizable", "result.kind.podcast", fallback: "Podcast")
      /// Podcast episode
      internal static let podcastEpisode = L10n.tr("Localizable", "result.kind.podcastEpisode", fallback: "Podcast episode")
      /// App
      internal static let software = L10n.tr("Localizable", "result.kind.software", fallback: "App")
      /// App bundle
      internal static let softwarePackage = L10n.tr("Localizable", "result.kind.softwarePackage", fallback: "App bundle")
      /// Song
      internal static let song = L10n.tr("Localizable", "result.kind.song", fallback: "Song")
      /// TV episode
      internal static let tvEpisode = L10n.tr("Localizable", "result.kind.tvEpisode", fallback: "TV episode")
    }
    internal enum Wrapper {
      /// Artist
      internal static let artist = L10n.tr("Localizable", "result.wrapper.artist", fallback: "Artist")
      /// Audiobook
      internal static let audiobook = L10n.tr("Localizable", "result.wrapper.audiobook", fallback: "Audiobook")
      /// Collection
      internal static let collection = L10n.tr("Localizable", "result.wrapper.collection", fallback: "Collection")
      /// App
      internal static let software = L10n.tr("Localizable", "result.wrapper.software", fallback: "App")
      /// Track
      internal static let track = L10n.tr("Localizable", "result.wrapper.track", fallback: "Track")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
