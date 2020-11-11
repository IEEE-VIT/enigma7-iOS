//
//  XPTimeModel.swift
//  Enigma
//
//  Created by Aaryan Kothari on 11/11/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct XPTime: Codable{
   let timeLeft : Double?
    
    enum CodingKeys: String, CodingKey {
        case timeLeft = "time_left"
    }
}
