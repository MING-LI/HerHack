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
import SwiftyJSON

enum CarpoolStatus {
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
    
    init(dict: JSON) {
        let source_geopoint = dict["source_coordinates"] as! GeoPoint
        let source_coordinates = CLLocationCoordinate2D(latitude: source_geopoint.latitude, longitude: source_geopoint.longitude);
        let destination_geopoint = dict["destination_coordinates"] as! GeoPoint
        let destination_coordinates = CLLocationCoordinate2D(latitude: destination_geopoint.latitude, longitude: destination_geopoint.longitude)
        
        
        let user_offer_ride = CarpoolUser(dict: JSON(dict["user_offer_ride"]))
        let users_request_ride = JSON(dict["users_request_ride"])
        
        
        self.id = nil
        self.source = dict["source"] as! String
        self.source_coordinates = source_coordinates
        self.destination = dict["destination"] as! String
        self.destination_coordinates = destination_coordinates
        self.offered_seats = dict["offered_seats"] as! Int
        self.created_at = (dict["created_at"] as! Timestamp).dateValue()
        self.start_at = (dict["start_at"] as! Timestamp).dateValue()
        self.end_at = (dict["end_at"] as! Timestamp).dateValue()
        self.user_offer_ride =  user_offer_ride
        self.users_request_ride =  users_request_ride
        self.status = CarpoolStatus(rawValue:dict["status"] as! String)!
        self.vehicle_id = (dict["vehicle_id"] as! DocumentReference).documentID
    }
}
