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




class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        donateIntent()
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    private func donateIntent(){
        let intent = LeaderboardIntent()
        intent.suggestedInvocationPhrase = "enigma leaderboard"
        let interaction = INInteraction(intent: intent, response: nil)
            
        interaction.donate { (error) in
            if error != nil {
                if let error = error as NSError? {
                    print("Interaction donation failed: \(error.description)")
                } else {
                    print("Successfully donated interaction")
                }
            }
        }
    }

}
