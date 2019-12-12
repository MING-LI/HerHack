//
//  CarpoolUser.swift
//  HerHack
//
//  Created by LabLamb on 9/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import Foundation

struct CarpoolUser: Codable {
    let user_id: String
    let user_name: String
    let is_accepted : Bool?
    
    enum CodingKeys: String, CodingKey {
        case user_id, user_name, is_accepted
    }
}

extension CarpoolUser {
    init(_ fromFirestore: [String:Any]) {
        self.init(
            user_id:fromFirestore["user_id"] as! String,
            user_name:fromFirestore["user_name"] as! String,
            is_accepted:fromFirestore["is_accepted"] as! Bool? ?? nil
        )
    }
}
