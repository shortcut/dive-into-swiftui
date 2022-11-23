//
//  ItunesItem+locale.swift
//  SearchDemo
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//

import Foundation
import ItunesApi

extension ItunesItem {
    var priceLocale: Locale? {
        guard let country else { return nil }
        let region = Locale.Region(country)
        return Locale(languageCode: Locale.current.language.languageCode, languageRegion: region)
    }
}
