//
//  Utils.swift
//  HerHack
//
//  Created by Mimosa Poon on 7/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit
import GoogleMaps

struct Constants {
    static let CarpoolScreenName = "Carpool"
    static let MapViewScreenName = "Map"
    
    static let Key = ProcessInfo.processInfo.environment["google_map_api_key"]
    static let MinimumSpacing: CGFloat = 6
    static let AppMargin: CGFloat = 15
    
    static let Fonts = (
        LargeBoldFont: UIFont.boldSystemFont(ofSize: 24),
        BoldFont: UIFont.boldSystemFont(ofSize: 18),
        SemiBold: UIFont.boldSystemFont(ofSize: 16),
        RegularFont: UIFont.systemFont(ofSize: UIFont.systemFontSize),
        SmallFont: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
    )
    
    static let Colors = (
        GreyColor: UIColor(red:0.70, green:0.70, blue:0.70, alpha:1.0),
        LightGreyColor: UIColor(red:0.84, green:0.84, blue:0.84, alpha:1.0),
        PaleGreyColor: UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1.0),
        Green: UIColor(red:0.00, green:0.65, blue:0.33, alpha:1.0),
        Red: UIColor(red: 219/255.0, green: 0.0/255.0, blue: 17/255.0, alpha: 1),
        Blue: UIColor(red: 34/255.0, green: 108/255.0, blue: 224/255.0, alpha: 1)
    )
    
    static func googleDirectionsAPI(src: CLLocationCoordinate2D, dest: CLLocationCoordinate2D) -> URL? {
        let queryParams = [
            URLQueryItem(name: "origin", value: "\(src.latitude),\(src.longitude)"),
            URLQueryItem(name: "destination", value: "\(dest.latitude),\(dest.longitude)"),
            URLQueryItem(name: "sensor", value: "false"),
            URLQueryItem(name: "mode", value: "driving"),
            URLQueryItem(name: "key", value: Constants.Key)
        ]
        
        var urlComp = URLComponents(string: "https://maps.googleapis.com/maps/api/directions/json")
        urlComp?.queryItems = queryParams
        return urlComp?.url
    }
}

