//
//  ProfileIntentHandler.swift
//  Enigma-Siri
//
//  Created by Aaryan Kothari on 26/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation
import UIKit
import Intents

class ProfileIntentHandler: NSObject, ProfileIntentHandling{
    func confirm(intent: ProfileIntent, completion: @escaping (ProfileIntentResponse) -> Void) {
        completion(ProfileIntentResponse(code: .ready, userActivity: nil))
    }
    
    func handle(intent: ProfileIntent, completion: @escaping (ProfileIntentResponse) -> Void) {
        let userActivity = NSUserActivity(activityType: NSStringFromClass(ProfileIntent.self))
        
        
        self.getUserDetails { (user,code) in
            
            guard code != 401 else{
                let response = ProfileIntentResponse(code: .authError, userActivity: userActivity)
                completion(response)
                return
            }
            
            guard let user = user else {
                let response = ProfileIntentResponse(code: .failureRequiringAppLaunch, userActivity: userActivity)
                completion(response)
                return
            }
            
            let response = ProfileIntentResponse(code: .success, userActivity: userActivity)
            let profile = User(identifier: "", display: "")
            profile.email = user.email ?? ""
            profile.score = NSNumber(value: user.points ?? 0)
            profile.xp = NSNumber(value: user.xp ?? 0)
            profile.solved = NSNumber(value: user.question_answered ?? 0)
            response.userDetails = profile
            completion(response)
        }
    }
    
    private func getUserDetails(completion : @escaping (UserDetails?,Int)->()){
        WebHelper.sendGETRequest(url: NetworkConstants.Users.userDetailsURL, parameters: [:], responseType: UserDetails.self,key: Keys.user) { (response, code) in
            completion(response,code)
        }
    }
}
