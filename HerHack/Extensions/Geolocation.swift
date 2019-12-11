//
//  Geolocation.swift
//  HerHack
//
//  Created by JohnC on 12/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    func toString() -> String{
        return "\(self.latitude),\(self.longitude)"
    }
}
