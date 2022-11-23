//
//  ItunesSearchSettings.Country.swift
//  Art Thief
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//  Copyright © 2019 Atelier Clockwork. All rights reserved.
//

import Foundation

public extension ItunesSearchQuery {
    // swiftlint:disable identifier_name
    enum Country: String, Hashable, CaseIterable, Identifiable, Codable {
        public var id: Self {
            self
        }

        case us = "US"
        case dk = "DK"
        case no = "NO"
        case se = "SE"
        case ro = "RO"
        case ua = "UA"
        case mk = "MK"
        case gb = "GB"
        case jp = "JP"
    }
    // swiftlint:enable identifier_name
}

extension ItunesSearchQuery.Country: CustomStringConvertible {
    public var description: String {
        switch self {
        case .us: return L10n.Country.us
        case .dk: return L10n.Country.dk
        case .gb: return L10n.Country.gb
        case .jp: return L10n.Country.jp
        case .no: return L10n.Country.no
        case .mk: return L10n.Country.mk
        case .ro: return L10n.Country.ro
        case .se: return L10n.Country.se
        case .ua: return L10n.Country.ua
        }
    }
}
