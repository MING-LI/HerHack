//
//  Carpool.swift
//  HerHack
//
//  Created by LabLamb on 6/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import Foundation

struct CarpoolRequest {
    var user_id: String
    var is_accepted : Bool
}

enum CarpoolStatus {
    case OPEN, FULL, ENDED
}

struct Carpool {
    var source: String
    var destination: String
    var offered_seats : Int
    var created_at: Date
    var start_at: Date
//  arrived_at: calculate by using the estimated time fetched from Google API
    var end_at: Date
    var user_offer_ride: String
    var users_request_ride: [CarpoolRequest]
    var status: CarpoolStatus
}
