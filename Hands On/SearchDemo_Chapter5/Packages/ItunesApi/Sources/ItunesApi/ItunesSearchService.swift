//
//  ItunesSearchService.swift
//  Art Thief
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//  Copyright © 2019 Atelier Clockwork. All rights reserved.
//

import Foundation
import Combine

public protocol ItunesSearchServiceProtocol {
    func search(for query: ItunesSearchQuery) async throws -> [ItunesItem]
}

public class ItunesSearchService: ItunesSearchServiceProtocol {
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        return jsonDecoder
    }()

    public init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    enum SearchError: Error {
        case noSearch
    }

    public func search(for query: ItunesSearchQuery) async throws -> [ItunesItem] {
        guard let url = query.urlRequest else { throw SearchError.noSearch }
        let (data, _) = try await urlSession.data(from: url)

        let result = try jsonDecoder.decode(ItunesSearchResponse.self, from: data)
        return result.results
    }
}

extension ItunesSearchQuery {
    var urlRequest: URL? {
        guard self.searchTerm.count >= 1 else { return nil }
        guard var components = URLComponents(string: "https://itunes.apple.com/search") else {
            fatalError("Failed to make url")
        }
        components.queryItems = [
            URLQueryItem(name: "term", value: searchTerm.iTunesEncoded),
            attribute.urlQueryItem,
            country.urlQueryItem,
            mediaType.urlQueryItem,
            entity.urlQueryItem,
            allowExplicitContent ? nil : URLQueryItem(name: "explicit", value: "no")
            ].compactMap { $0 }
        return components.url
    }
}

private extension ItunesSearchQuery.Attribute {
    var urlQueryItem: URLQueryItem? {
        guard self != .none else { return nil }
        return URLQueryItem(name: "attribute", value: rawValue)
    }
}

private extension ItunesSearchQuery.Country {
    var urlQueryItem: URLQueryItem {
        return URLQueryItem(name: "country", value: rawValue)
    }
}

private extension ItunesSearchQuery.Media {
    var urlQueryItem: URLQueryItem {
        return URLQueryItem(name: "media", value: rawValue)
    }
}

private extension ItunesSearchQuery.Entity {
    var urlQueryItem: URLQueryItem? {
        guard self != .none else { return nil }
        return URLQueryItem(name: "entity", value: rawValue)
    }
}

extension String {
    var iTunesEncoded: String {
        let strings = split(separator: " ").map(String.init).map({ $0.percentEncode() })
        return strings.joined(separator: "+")
    }

    private func percentEncode() -> String {
        guard let encoded = addingPercentEncoding(withAllowedCharacters: .iTunesAllowed) else {
            fatalError("Failed to encode \(self) for iTunes")
        }
        return encoded
    }
}

private extension CharacterSet {
    static let iTunesAllowed: CharacterSet = {
        CharacterSet.alphanumerics.union(CharacterSet(charactersIn: ".-_*"))
    }()
}
