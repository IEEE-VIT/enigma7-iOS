//
//  Appconstants.swift
//  Enigma
//
//  Created by Aaryan Kothari on 28/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct AppConstants {
    struct CellId {
        static let leaderboardCell = "leadercell"
    }
    
    struct Error {
        static let usernameErrorPrefix = "________________\nInvalidUsername.\n-> "
        static let emptyAnswer = "Answer can not be empty!"
        static let emptyUsername = "Username Empty!"
        static let misc = "An Error occured :("
    }
    
    struct ViewController {
        static let PlayViewController = "PlayViewController"
        static let LeaderboardViewController = "LeaderboardViewController"
        static let StoryViewController = "StoryViewController"
        static let ProfileViewController = "ProfileViewController"
        static let RulesViewController = "RulesViewController"
        static let HomeViewController = "HomeViewController"
        static let CountdownViewController = "CountdownViewController"
        static let UserNameViewController = "UserNameViewController"
    }
    
    struct Image {
        static let share = "share"
        static let hint = "Hint"
    }
}
