//
//  LeaderboardModel.swift
//  Enigma
//
//  Created by Aaryan Kothari on 31/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct Leaderboard: Decodable {
    var username : String?
    var solved : Int?
    var score : Int?
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case solved = "question_answered"
        case score = "points"
    }
}
