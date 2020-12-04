//
//  Appconstants.swift
//  Enigma
//
//  Created by Aaryan Kothari on 28/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct AppConstants {
    
    static let privacy = "https://enigma.ieeevit.org/static/media/Privacy.6b994fbf.pdf"
    
    struct CellId {
        static let leaderboardCell = "leadercell"
        static let rulesCell = "rulescell"
        static let xpCell = "xpcell"
    }
    
    struct Error {
        static let usernameErrorPrefix = "________________\nInvalidUsername.\n-> "
        static let emptyAnswer = "Answer can not be empty!"
        static let emptyUsername = "Username Empty!"
        static let emptySource = "Where did you hear abous us?"
        static let emptyYear = "when will you graduate"
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
        static let startDate = "2020-12-04 16:20:00"
        static let dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    struct Google {
        static let clientId = "55484635453-2fmn476nlr2it49soaejbeqj29lq0k6k.apps.googleusercontent.com"
        static let serverClientId = "55484635453-c46tes445anbidhb2qnmb2qs618mvpni.apps.googleusercontent.com"
    }
    
    struct Story {
        static let username = " <username> "
        static let username2 = "  <username>  "
        static let lineBreak = " <br> "
        static let lineBreak2 = "<br>"
    }
    
}
