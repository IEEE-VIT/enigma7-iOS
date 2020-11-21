//
//  Status.swift
//  Enigma
//
//  Created by Aaryan Kothari on 21/11/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct Status : Decodable {
    var started : Bool?
    var startDate : String?
    var startTime : String?
    
    enum CodingKeys: String, CodingKey {
        case started = "has_started"
        case startDate = "start_date"
        case startTime = "start_time"
    }
}
