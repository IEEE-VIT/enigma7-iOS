//
//  LeaderboardIntentHandler.swift
//  Enigma-Siri
//
//  Created by Aaryan Kothari on 25/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

class LeaderboardIntentHandler: NSObject, LeaderboardIntentHandling{
    func confirm(intent: LeaderboardIntent, completion: @escaping (LeaderboardIntentResponse) -> Void) {
        ServiceController.shared.getLeaderboard { (response) in
            if let _ = response {
                completion(LeaderboardIntentResponse(code: .ready, userActivity: .none))
            } else {
                completion(LeaderboardIntentResponse(code: .failure, userActivity: .none))
            }
        }
    }
    
    func handle(intent: LeaderboardIntent, completion: @escaping (LeaderboardIntentResponse) -> Void) {
        let userActivity = NSUserActivity(activityType: NSStringFromClass(LeaderboardIntent.self))
        let response = LeaderboardIntentResponse(code: .success, userActivity: userActivity)
        ServiceController.shared.getLeaderboard { (leaderboard) in
            guard let leaderboard = leaderboard else { return }
            var prop = [Leader]()
            for leader in leaderboard{
                let property = Leader(identifier: "", display: "")
                property.rank = 1
                property.username = leader.username ?? ""
                prop.append(property)
            }
            response.leaderboard = prop
            completion(response)
        }
    }
    
}
