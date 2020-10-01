//
//  ServiceController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 08/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

class ServiceController {
    
    static let shared: ServiceController = ServiceController()
    
    func getUserDetails(completion : @escaping (UserDetails?)->()){
        WebHelper.sendGETRequest(url: NetworkConstants.Users.userDetailsURL, parameters: [:], responseType: UserDetails.self,key: Keys.user) { (response, error) in
            completion(response)
        }
    }
    
    func getLeaderboard(completion : @escaping ([Leaderboard]?)->()){
        WebHelper.sendGETRequest(url: NetworkConstants.Game.leaderboardURL, parameters: [:], responseType: [Leaderboard].self,key: Keys.leaderboard) { (response, error) in
            completion(response)
        }
    }
    
    func getQuestion(completion : @escaping (Question?)->()){
        WebHelper.sendGETRequest(url: NetworkConstants.Game.questionURL, parameters: [:], responseType: Question.self,key: Keys.question) { (response, error) in
            completion(response)
        }
    }
    
    func getHint(completion : @escaping (Hint?)->()){
        WebHelper.sendGETRequest(url: NetworkConstants.Game.hintURL, parameters: [:], responseType: Hint.self,key: Keys.question) { (response, error) in
            completion(response)
        }
    }
    
}
