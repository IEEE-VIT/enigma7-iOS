//
//  UserDetails Response.swift
//  Enigma
//
//  Created by Aaryan Kothari on 29/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct UserDetails : Decodable{
    let id: Int?
    let username: String?
    let email: String?
    let points: Int?
    let question_answered: Int?
    let xp: Int?
    let no_of_hints_used: Int?
    let rank: Int?
    let user_status: UserStatus
}

struct UserStatus : Decodable {
    let accept_close_answerlet: Int?
    let hint_poweruplet: Int?
    let hint_usedlet: Int?
    let skip_poweruplet: Int?
}
