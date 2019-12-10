//
//  User.swift
//  HerHack
//
//  Created by JohnC on 7/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import Foundation

struct User: Codable {
    var name: String
    var email: String
    
    enum CodingKeys: String, CodingKey {
        case name, email
    }
}
