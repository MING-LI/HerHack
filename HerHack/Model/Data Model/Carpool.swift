//
//  Carpool.swift
//  HerHack
//
//  Created by LabLamb on 6/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase

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

enum CarpoolStatus: String {
    case OPEN, FULL, ENDED
}

struct Carpool {
    var id: String? // document id in firestore
    let source: String
    let source_coordinates: CLLocationCoordinate2D
    let destination: String
    let destination_coordinates: CLLocationCoordinate2D
    let offered_seats : Int
    let created_at: Date
    let start_at: Date
    let end_at: Date // calculated using estimated time from Google Direction API
    let user_offer_ride: CarpoolUser
    let users_request_ride: [CarpoolUser]
    let status: CarpoolStatus
    let vehicle_id: String
}

extension Carpool {
    init(dict: [String: Any]) {
        let source_geopoint = dict["source_coordinates"] as! GeoPoint
        let source_coordinates = CLLocationCoordinate2D(latitude: source_geopoint.latitude, longitude: source_geopoint.longitude);
        let destination_geopoint = dict["destination_coordinates"] as! GeoPoint
        let destination_coordinates = CLLocationCoordinate2D(latitude: destination_geopoint.latitude, longitude: destination_geopoint.longitude)
        let user_offer_ride = CarpoolUser(dict: (dict["user_offer_ride"] as! NSDictionary) as! [String : Any])
        let users_request_ride = (dict["users_request_ride"] as! [NSDictionary]).map{CarpoolUser(dict: $0 as! [String : Any])}
       
        self.init(
            id: nil,
            source:dict["source"] as! String,
            source_coordinates:source_coordinates,
            destination:dict["destination"] as! String,
            destination_coordinates:destination_coordinates,
            offered_seats:dict["offered_seats"] as! Int,
            created_at:(dict["created_at"] as! Timestamp).dateValue(),
            start_at:(dict["start_at"] as! Timestamp).dateValue(),
            end_at:(dict["end_at"] as! Timestamp).dateValue(),
            user_offer_ride:user_offer_ride,
            users_request_ride:users_request_ride,
            status:CarpoolStatus(rawValue:dict["status"] as! String)!,
            vehicle_id:(dict["vehicle_id"] as! DocumentReference).documentID
        )
    }
}
