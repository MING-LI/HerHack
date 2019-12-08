//
//  Carpool.swift
//  HerHack
//
//  Created by LabLamb on 6/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import Foundation

struct CarpoolRequest {
    let user_id: String
    let is_accepted : Bool
}

enum CarpoolStatus {
    case OPEN, FULL, ENDED
}

struct Carpool {
    let source: String
    let destination: String
    let offered_seats : Int
    let created_at: Date
    let start_at: Date
//  arrived_at: calculate by using the estimated time fetched from Google API
    let end_at: Date
    let user_offer_ride: String
    let users_request_ride: [CarpoolRequest]
    let status: CarpoolStatus
}
