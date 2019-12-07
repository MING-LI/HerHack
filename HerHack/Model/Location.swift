//
//  Location.swift
//  HerHack
//
//  Created by JohnC on 7/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import Foundation

struct Geopoint {
    var lat : Float
    var lng : Float
}
struct Location {
    var address: String
    var area : String
    var coordinates: Geopoint
}
