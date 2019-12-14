//
//  GoogleService.swift
//  HerHack
//
//  Created by JohnC on 12/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation

class GoogleService {
    
    public static let shared = GoogleService()
    
    func getDistanceAndDuration(source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D, completion:@escaping (DistanceAndDuration)->()) {
        AF.request("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=\(source.toString())&destinations=\(destination.toString())&key=\(Constants.Key ?? "")").responseJSON { response in
            let json = JSON(response.data as Any)
            if let distance = json["rows"][0]["elements"][0]["distance"]["value"].int, let duration = json["rows"][0]["elements"][0]["duration"]["value"].int{
                let res = DistanceAndDuration(distance:distance, duration:duration)
                completion(res)
            }
        }
    }
    
    func postToPipeline(data: PipelineData,completion:@escaping ()->()){
        let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
        
        AF.request("https://us-central1-agile-device-260201.cloudfunctions.net/finish-ride-func",
           method: .post,
           parameters: data.dictionary,
           encoding: JSONEncoding.default,
           headers: headers).responseString { response in
            completion()
        }
    }
}
