//
//  LeaderboardIntentHandler.swift
//  Enigma-Siri
//
//  Created by Aaryan Kothari on 25/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation
import UIKit
import Intents

class LeaderboardIntentHandler: NSObject, LeaderboardIntentHandling{
    
        
    func confirm(intent: LeaderboardIntent, completion: @escaping (LeaderboardIntentResponse) -> Void) {
        completion(LeaderboardIntentResponse(code: .ready, userActivity: nil))
    }
    
    func handle(intent: LeaderboardIntent, completion: @escaping (LeaderboardIntentResponse) -> Void) {
        let userActivity = NSUserActivity(activityType: NSStringFromClass(LeaderboardIntent.self))
        self.getLeaderboard { (leaderboard,code) in
            guard code != 401 else{
                let response = LeaderboardIntentResponse(code: .autherror, userActivity: userActivity)
                completion(response)
                return
            }
            

            guard let leaderboard = leaderboard else {
                let response = LeaderboardIntentResponse(code: .failureRequiringAppLaunch, userActivity: userActivity)
                completion(response)
                return
            }
            
            let response = LeaderboardIntentResponse(code: .top, userActivity: userActivity)
            
            var prop = [Leader]()
            for leader in leaderboard{
                let property = Leader(identifier: "", display: "")
                property.rank = 1
                property.username = leader.username ?? ""
                property.solved = NSNumber(value: leader.solved ?? 0)
                property.score = NSNumber(value: leader.score ?? 0)
                prop.append(property)
            }
            response.leaderboard = prop
            completion(response)
        }
    }
    
    private func getLeaderboard(w:Bool=false,completion : @escaping ([Leaderboard]?,Int)->()){
        WebHelper.sendGETRequest(url: NetworkConstants.Game.leaderboardURL, parameters: [:], responseType: [Leaderboard].self,key: Keys.leaderboard) { (response,code) in
            completion(response,code)
        }
    }
}
