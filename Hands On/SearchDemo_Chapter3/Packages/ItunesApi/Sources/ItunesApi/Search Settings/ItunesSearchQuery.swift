//
//  ItunesSearchSettings.swift
//  Art Thief
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//  Copyright © 2019 Atelier Clockwork. All rights reserved.
//

import Foundation

public struct ItunesSearchQuery: Hashable, Codable {
    public var searchTerm: String
    public var country: ItunesSearchQuery.Country
    public var mediaType: ItunesSearchQuery.Media {
        didSet {
            if !mediaType.allowedEntities.contains(entity) {
                entity = .none
            }
            if !mediaType.allowedAttributes.contains(attribute) {
                attribute = .none
            }
        }
    }
    public var entity: ItunesSearchQuery.Entity
    public var attribute: ItunesSearchQuery.Attribute
    public var allowExplicitContent: Bool

    public init() {
        searchTerm = ""
        country = .us
        mediaType = .all
        entity = .none
        attribute = .none
        allowExplicitContent = true
    }
}
