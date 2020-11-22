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
        static let specialCharacters = "Special charcaters are not allowed!"
        static let uhOh = "Uh oh 😕"
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
        static let StorySnippetViewController = "StorySnippetViewController"
    }
    
    struct Image {
        static let share = "share"
        static let hint = "Hint"
    }
    
    struct Date {
        static let startDate = "2020-11-24 16:20:00" //TODO put actual date
        static let dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    struct Google {
        static let clientId = "55484635453-2fmn476nlr2it49soaejbeqj29lq0k6k.apps.googleusercontent.com"
        static let serverClientId = "55484635453-c46tes445anbidhb2qnmb2qs618mvpni.apps.googleusercontent.com"
    }
    
}
