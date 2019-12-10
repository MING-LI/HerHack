//
//  Codable.swift
//  HerHack
//
//  Created by JohnC on 10/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import Foundation

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
}
