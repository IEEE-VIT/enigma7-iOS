//
//  NetworkConstants.swift
//  Enigma
//
//  Created by Aaryan Kothari on 08/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct NetworkConstants {
    
    struct Users {
    // public static let baseURL = "https://enigma7-backend.herokuapp.com/api/v1/users/"
        public static let baseURL = "https://enigma-api-staging.ieeevit.org/api/v1/users/"
        
        public static let googleURL = baseURL + "auth/google/"
        public static let appleURL = baseURL + "auth/apple/"
        public static let editUsernameURL = baseURL + "me/edit/"
        public static let userDetailsURL = baseURL + "me/"
        public static let logoutURL = baseURL + "logout/"

    }

    
    struct Game {
    // public static let baseURL = "https://enigma7-backend.herokuapp.com/api/v1/game/"
        public static let baseURL = "https://enigma-api-staging.ieeevit.org/api/v1/game/"

        public static let leaderboardURL = baseURL + "leaderboard/"
        public static let questionURL = baseURL + "question/"
        public static let hintURL = baseURL + "hint/"
        public static let hintPowerupURL = baseURL + "powerup/hint/"
        public static let skipPowerupURL = baseURL + "powerup/skip/"
        public static let closeAnswerPowerupURL = baseURL + "powerup/close-answer/"
        public static let answerURL = baseURL + "answer/"
        public static let xpTimeURL = baseURL + "xp-time/"
    }
    
}


