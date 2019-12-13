//
//  PipelineData.swift
//  HerHack
//
//  Created by JohnC on 14/12/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import Foundation

struct PipelineData: Codable {
    let StartTime: Int
    let EndTime: Int
    let Dest: String
    let Source: String
    let PassengerId: String
    let DriverId: String
    let Rating: Int
    let Comment: String
    
    enum PipelineDataKeys: String, CodingKey {
        case StartTime, EndTime, Dest, Source, PassengerId, DriverId, Rating, Comment
    }
}
