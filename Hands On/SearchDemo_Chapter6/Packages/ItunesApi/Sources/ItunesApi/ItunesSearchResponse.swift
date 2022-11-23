//
//  ItunesSearchResponse.swift
//  Art Thief
//
//  Created by Shortcut for the 23rd of November, 2022 Dive into SwiftUI Masterclass.
//  Copyright © 2019 Atelier Clockwork. All rights reserved.
//

import Foundation
import os

struct ItunesSearchResponse: Decodable {
    let resultCount: Int
    let results: [ItunesItem]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        resultCount = try container.decode(Int.self, forKey: .resultCount)
        results = try container.decodeArrayAndReportErrors(ItunesItem.self, forKey: .results)
    }

    private enum CodingKeys: String, CodingKey {
        case resultCount, results
    }
}

private extension KeyedDecodingContainer {
    func decodeArrayAndReportErrors<Decoded: Decodable>(_ type: Decoded.Type, forKey key: Key) throws -> [Decoded] {
        var container = try self.nestedUnkeyedContainer(forKey: key)
        return try container.decodeAndReportErrors(Decoded.self)
    }
}

private extension UnkeyedDecodingContainer {
    mutating func decodeAndReportErrors<Decoded: Decodable>(_ type: Decoded.Type) throws -> [Decoded] {
        var decoded = [Decoded]()
        while !self.isAtEnd {
            do {
                decoded.append(try self.decode(Decoded.self))
            } catch {
                os_log("Falied to decode with error %@", String(describing: error))
                _ = try self.decode(Nothing.self)
            }
        }
        return decoded
    }
}

private struct Nothing: Decodable {}
