// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum ClippedText {
    /// Less
    internal static let less = L10n.tr("Localizable", "clipped_text.less", fallback: "Less")
    /// More
    internal static let more = L10n.tr("Localizable", "clipped_text.more", fallback: "More")
  }
  internal enum Detail {
    internal enum Collection {
      /// Artist
      internal static let artistName = L10n.tr("Localizable", "detail.collection.artistName", fallback: "Artist")
      /// Censored name
      internal static let censoredName = L10n.tr("Localizable", "detail.collection.censoredName", fallback: "Censored name")
      /// Explicitness
      internal static let explicitness = L10n.tr("Localizable", "detail.collection.explicitness", fallback: "Explicitness")
      /// Name
      internal static let name = L10n.tr("Localizable", "detail.collection.name", fallback: "Name")
      /// Collection
      internal static let title = L10n.tr("Localizable", "detail.collection.title", fallback: "Collection")
      /// Number of tracks
      internal static let trackCount = L10n.tr("Localizable", "detail.collection.trackCount", fallback: "Number of tracks")
      internal enum Price {
        /// HD Price
        internal static let hd = L10n.tr("Localizable", "detail.collection.price.hd", fallback: "HD Price")
        /// Price
        internal static let sd = L10n.tr("Localizable", "detail.collection.price.sd", fallback: "Price")
      }
    }
    internal enum General {
      /// Advisories
      internal static let advisories = L10n.tr("Localizable", "detail.general.advisories", fallback: "Advisories")
      /// User rating
      internal static let averageUserRating = L10n.tr("Localizable", "detail.general.averageUserRating", fallback: "User rating")
      /// Rating
      internal static let contentAdvisoryRating = L10n.tr("Localizable", "detail.general.contentAdvisoryRating", fallback: "Rating")
      /// Copyright
      internal static let copyright = L10n.tr("Localizable", "detail.general.copyright", fallback: "Copyright")
      /// Release date
      internal static let currentVersionReleaseDate = L10n.tr("Localizable", "detail.general.currentVersionReleaseDate", fallback: "Release date")
      /// Disc
      internal static let discCount = L10n.tr("Localizable", "detail.general.discCount", fallback: "Disc")
      /// %i of %i
      internal static func discFormat(_ p1: Int, _ p2: Int) -> String {
        return L10n.tr("Localizable", "detail.general.discFormat", p1, p2, fallback: "%i of %i")
      }
      /// Features
      internal static let features = L10n.tr("Localizable", "detail.general.features", fallback: "Features")
      /// FileSize
      internal static let fileSize = L10n.tr("Localizable", "detail.general.fileSize", fallback: "FileSize")
      /// Game Center
      internal static let gameCenterEnabled = L10n.tr("Localizable", "detail.general.gameCenterEnabled", fallback: "Game Center")
      /// Genre
      internal static let genre = L10n.tr("Localizable", "detail.general.genre", fallback: "Genre")
      /// Genres
      internal static let genres = L10n.tr("Localizable", "detail.general.genres", fallback: "Genres")
      /// Itunes Extras
      internal static let hasItunesExtras = L10n.tr("Localizable", "detail.general.hasItunesExtras", fallback: "Itunes Extras")
      /// Streamable
      internal static let isStreamable = L10n.tr("Localizable", "detail.general.isStreamable", fallback: "Streamable")
      /// VPP enabled
      internal static let isVppDeviceBasedLicensingEnabled = L10n.tr("Localizable", "detail.general.isVppDeviceBasedLicensingEnabled", fallback: "VPP enabled")
      /// Languages
      internal static let languages = L10n.tr("Localizable", "detail.general.languages", fallback: "Languages")
      /// OS Requirement
      internal static let minimumOsVersion = L10n.tr("Localizable", "detail.general.minimumOsVersion", fallback: "OS Requirement")
      /// Number of ratings current version
      internal static let ratingCount = L10n.tr("Localizable", "detail.general.ratingCount", fallback: "Number of ratings current version")
      /// Release date
      internal static let releaseDate = L10n.tr("Localizable", "detail.general.releaseDate", fallback: "Release date")
      /// Release notes
      internal static let releaseNotes = L10n.tr("Localizable", "detail.general.releaseNotes", fallback: "Release notes")
      /// Seller
      internal static let sellerName = L10n.tr("Localizable", "detail.general.sellerName", fallback: "Seller")
      /// Supported devices
      internal static let supportedDevices = L10n.tr("Localizable", "detail.general.supportedDevices", fallback: "Supported devices")
      /// Version user rating
      internal static let thisVersionAverageUserRating = L10n.tr("Localizable", "detail.general.thisVersionAverageUserRating", fallback: "Version user rating")
      /// Version
      internal static let version = L10n.tr("Localizable", "detail.general.version", fallback: "Version")
      internal enum Artist {
        /// Artist name
        internal static let name = L10n.tr("Localizable", "detail.general.artist.name", fallback: "Artist name")
      }
      internal enum Ratings {
        /// %i ratings
        internal static func numberOfRatings(_ p1: Int) -> String {
          return L10n.tr("Localizable", "detail.general.ratings.numberOfRatings", p1, fallback: "%i ratings")
        }
      }
    }
    internal enum Screenshots {
      /// appleTv Screenshots
      internal static let appleTv = L10n.tr("Localizable", "detail.screenshots.appleTv", fallback: "appleTv Screenshots")
      /// iPad Screenshots
      internal static let iPad = L10n.tr("Localizable", "detail.screenshots.iPad", fallback: "iPad Screenshots")
      /// Screenshots
      internal static let standard = L10n.tr("Localizable", "detail.screenshots.standard", fallback: "Screenshots")
    }
    internal enum Track {
      /// Rating
      internal static let contentRating = L10n.tr("Localizable", "detail.track.contentRating", fallback: "Rating")
      /// Rating
      internal static let explicitness = L10n.tr("Localizable", "detail.track.explicitness", fallback: "Rating")
      /// Name
      internal static let name = L10n.tr("Localizable", "detail.track.name", fallback: "Name")
      /// Track
      internal static let position = L10n.tr("Localizable", "detail.track.position", fallback: "Track")
      /// %i of %i
      internal static func positionFormat(_ p1: Int, _ p2: Int) -> String {
        return L10n.tr("Localizable", "detail.track.positionFormat", p1, p2, fallback: "%i of %i")
      }
      /// Length
      internal static let time = L10n.tr("Localizable", "detail.track.time", fallback: "Length")
      /// Track
      internal static let title = L10n.tr("Localizable", "detail.track.title", fallback: "Track")
      /// Censored Name
      internal static let trackCensoredName = L10n.tr("Localizable", "detail.track.trackCensoredName", fallback: "Censored Name")
      internal enum Price {
        /// HD Price
        internal static let hd = L10n.tr("Localizable", "detail.track.price.hd", fallback: "HD Price")
        /// Price
        internal static let sd = L10n.tr("Localizable", "detail.track.price.sd", fallback: "Price")
        internal enum Rental {
          /// HD rental price
          internal static let hd = L10n.tr("Localizable", "detail.track.price.rental.hd", fallback: "HD rental price")
          /// Rental price
          internal static let sd = L10n.tr("Localizable", "detail.track.price.rental.sd", fallback: "Rental price")
        }
      }
    }
  }
  internal enum Favorites {
    /// Favorites
    internal static let title = L10n.tr("Localizable", "favorites.title", fallback: "Favorites")
    internal enum Empty {
      /// Find your Itunes entertainment
      /// by Type title, categories, years, etc;
      internal static let body = L10n.tr("Localizable", "favorites.empty.body", fallback: "Find your Itunes entertainment\nby Type title, categories, years, etc;")
      /// Go to Search
      internal static let cta = L10n.tr("Localizable", "favorites.empty.cta", fallback: "Go to Search")
      /// There is no data yet!
      internal static let title = L10n.tr("Localizable", "favorites.empty.title", fallback: "There is no data yet!")
    }
    internal enum Tabbar {
      /// Favorites
      internal static let title = L10n.tr("Localizable", "favorites.tabbar.title", fallback: "Favorites")
    }
  }
  internal enum ItemOfTheDay {
  	/// Item of the day
  	internal static let title = L10n.tr("Localizable", "itemOfTheDay.title", fallback: "Item of the day")
    internal enum Tabbar {
  	/// Daily item
  	internal static let title = L10n.tr("Localizable", "itemOfTheDay.tabbar.title", fallback: "Daily item")
    }
  }
  internal enum HumanReadable {
    /// No
    internal static let `false` = L10n.tr("Localizable", "human_readable.false", fallback: "No")
    /// Yes
    internal static let `true` = L10n.tr("Localizable", "human_readable.true", fallback: "Yes")
  }
  internal enum Search {
    /// Localizable.strings
    ///   SearchDemo
    /// 
    ///   Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
    internal static let title = L10n.tr("Localizable", "search.title", fallback: "Itunes")
    internal enum Error {
      /// Ops! Something has gone wrong
      internal static let body = L10n.tr("Localizable", "search.error.body", fallback: "Ops! Something has gone wrong")
    }
    internal enum NoResults {
      /// No results for: "%@"
      internal static func body(_ p1: Any) -> String {
        return L10n.tr("Localizable", "search.noResults.body", String(describing: p1), fallback: "No results for: \"%@\"")
      }
    }
    internal enum Tabbar {
      /// Search
      internal static let title = L10n.tr("Localizable", "search.tabbar.title", fallback: "Search")
    }
    internal enum Toolbar {
      /// Settings
      internal static let settings = L10n.tr("Localizable", "search.toolbar.settings", fallback: "Settings")
    }
    internal enum Waiting {
      /// Enter text to search.
      internal static let body = L10n.tr("Localizable", "search.waiting.body", fallback: "Enter text to search.")
      /// There is no data yet!
      internal static let title = L10n.tr("Localizable", "search.waiting.title", fallback: "There is no data yet!")
    }
  }
  internal enum Settings {
    /// Allow explicit results
    internal static let allowExplicit = L10n.tr("Localizable", "settings.allow_explicit", fallback: "Allow explicit results")
    /// Attribute
    internal static let attribute = L10n.tr("Localizable", "settings.attribute", fallback: "Attribute")
    /// Country
    internal static let country = L10n.tr("Localizable", "settings.country", fallback: "Country")
    /// Entity
    internal static let entity = L10n.tr("Localizable", "settings.entity", fallback: "Entity")
    /// Media Type
    internal static let mediaType = L10n.tr("Localizable", "settings.media_type", fallback: "Media Type")
    /// Settings
    internal static let title = L10n.tr("Localizable", "settings.title", fallback: "Settings")
    internal enum Toolbar {
      /// Done
      internal static let done = L10n.tr("Localizable", "settings.toolbar.done", fallback: "Done")
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
