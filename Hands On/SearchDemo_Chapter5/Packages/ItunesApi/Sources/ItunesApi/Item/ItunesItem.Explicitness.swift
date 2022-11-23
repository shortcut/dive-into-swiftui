//
//  ItunesItem.Explicitness.swift
//  Art Thief
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//  Copyright © 2019 Atelier Clockwork. All rights reserved.
//

import Foundation

extension ItunesItem {
    public enum Explicitness: String, Codable, CustomStringConvertible {
        case cleaned
        case explicit
        case notExplicit

        public var description: String {
            switch self {
            case .cleaned: return L10n.Result.Explicitness.cleaned
            case .explicit: return L10n.Result.Explicitness.explicit
            case .notExplicit: return L10n.Result.Explicitness.notExplicit
            }
        }
    }
}
