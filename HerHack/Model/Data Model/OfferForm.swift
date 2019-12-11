//
//  OfferForm.swift
//  HerHack
//
//  Created by JohnC on 12/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import Foundation
import CoreLocation

struct OfferFormData {
    var source: String = ""
    var source_coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var destination: String = ""
    var destination_coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var offered_seats : Int = 0
    var start_at: Date = Date()
}
