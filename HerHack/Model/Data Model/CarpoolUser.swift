//
//  CarpoolUser.swift
//  HerHack
//
//  Created by LabLamb on 9/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import Firebase
import SwiftyJSON

struct CarpoolUser {
    let user_id: String
    let user_name: String
    let is_accepted : Bool?
}

extension CarpoolUser {
    init(dict: [String:Any]) {
        self.init(
            user_id:(dict["user_id"] as! DocumentReference).documentID,
            user_name:dict["user_name"] as! String,
            is_accepted:dict["is_accepted"] as! Bool? ?? nil
        )
    }
}
