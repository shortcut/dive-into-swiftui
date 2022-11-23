//
//  ItunesItem.WrapperType.swift
//  Art Thief
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//  Copyright © 2019 Atelier Clockwork. All rights reserved.
//

import Foundation

extension ItunesItem {
    public enum WrapperType: String, Codable, CustomStringConvertible {
        case track
        case collection
        case artist
        case audiobook
        case software

        public var description: String {
            switch self {
            case .track: return L10n.Result.Wrapper.track
            case .collection: return L10n.Result.Wrapper.collection
            case .artist: return L10n.Result.Wrapper.artist
            case .audiobook: return L10n.Result.Wrapper.audiobook
            case .software: return L10n.Result.Wrapper.software
            }
        }
    }
}
