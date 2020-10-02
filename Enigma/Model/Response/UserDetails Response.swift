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
}


//{
//    email = "aaryan.kothari@gmail.com";
//    id = 2;
//    "no_of_hints_used" = 0;
//    points = 0;
//    "question_answered" = 0;
//    rank = 1;
//    "user_status" =     {
//        "accept_close_answer" = 0;
//        "hint_powerup" = 0;
//        "hint_used" = 0;
//        "skip_powerup" = 0;
//    };
//    username = Aaryan;
//    xp = 100000;
//}
