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
    
    init(dict: JSON) {
        self.user_id = (dict["user_id"].rawValue as! DocumentReference).documentID
        self.user_name = dict["user_name"].stringValue
        self.is_accepted = dict["is_accepted"].boolValue
    }
}
