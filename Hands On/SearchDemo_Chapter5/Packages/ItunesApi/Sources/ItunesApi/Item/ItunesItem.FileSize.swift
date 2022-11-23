//
//  ItunesItem.FileSize.swift
//  Art Thief
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//  Copyright © 2019 Atelier Clockwork. All rights reserved.
//

import Foundation

extension ItunesItem {
    public struct FileSize: Codable, Hashable {
        public var bytes: Int64

        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            do {
                bytes = try container.decode(Int64.self)
            } catch {
                let byteString = try container.decode(String.self)
                guard let bytes = Self.rawDecoder.number(from: byteString)?.int64Value else {
                    throw DecodingError.dataCorruptedError(in: container,
                                                           debugDescription: "Failed to make an int from \(byteString)")
                }
                self.bytes = bytes
            }
        }

        static let rawDecoder: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.locale = Locale(languageCode: .english, languageRegion: .unitedStates)
            return formatter
        }()
    }
}
