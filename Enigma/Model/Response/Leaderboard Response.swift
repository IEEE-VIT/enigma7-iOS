//
//  LeaderboardModel.swift
//  Enigma
//
//  Created by Aaryan Kothari on 31/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct LeaderboardResponse: Decodable {
    let username : String?
    let solved : Int?
    let score : Int?
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case solved = "question_answered"
        case score = "points"
    }
}
