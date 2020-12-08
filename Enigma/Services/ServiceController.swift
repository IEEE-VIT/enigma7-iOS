//
//  ServiceController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 08/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

//MARK: --- CONTROLLER FOR 'GET' REQUESTS ---

class ServiceController {
    
    static let shared: ServiceController = ServiceController()
    
    /// `GET` user details
    /// `key` and `username` persisted here
    func getUserDetails(completion : @escaping (UserDetails?)->()) {
        WebHelper.sendGETRequest(url: NetworkConstants.Users.userDetailsURL, parameters: [:], responseType: UserDetails.self,key: Keys.user) { (response, _) in
            if let xp = response?.xp { UserDefaults.standard.set(xp, forKey: Keys.xp) }
            if let username = response?.username { UserDefaults.standard.set(username, forKey: Keys.username) }
            completion(response)
        }
    }
    
    /// `GET` Leaderboard
    func getLeaderboard(completion : @escaping ([Leaderboard]?)->()) {
        WebHelper.sendGETRequest(url: NetworkConstants.Game.leaderboardURL, parameters: [:], responseType: [Leaderboard].self,key: Keys.leaderboard) { (response, _) in
            completion(response)
        }
    }
    
    /// `GET` Question
    func getQuestion(completion : @escaping (Question?)->()) {
        WebHelper.sendGETRequest(url: NetworkConstants.Game.questionURL, parameters: [:], responseType: Question.self,key: Keys.question) { (response, error) in
            completion(response)
        }
    }
    
    /// `GET` Hint
    func getHint(powerup: Bool = false,completion : @escaping (Hint?)->()){
        let url = powerup ? NetworkConstants.Game.hintPowerupURL : NetworkConstants.Game.hintURL
        WebHelper.sendGETRequest(url: url, parameters: [:], responseType: Hint.self,key: Keys.hint) { (response, error) in
            if let xp = response?.xp { UserDefaults.standard.set(xp, forKey: Keys.xp) }
            completion(response)
        }
    }
    
    /// `GET` xp-time
    /// `returns` remaining time in seconds for next xp generation
    func getXpTime(completion : @escaping (Double)->()){
        WebHelper.sendGETRequest(url: NetworkConstants.Game.xpTimeURL, parameters: [:], responseType: XPTimeModel.self) { (response, _) in
            completion(response?.timeLeft ?? 0.0)
        }
    }
    
    /// `GET` Story
    /// `returns` latest story block depending on current question
    func getStory(completion : @escaping (Story?)->()){
        WebHelper.sendGETRequest(url: NetworkConstants.Game.storyURL, parameters: [:], responseType: Story.self) { (response, _) in
            completion(response)
        }
    }
    
    /// `GET` Full Story
    /// `returns` entire story until story block for current question
    func getFullStory(completion : @escaping ([Story])->()){
        WebHelper.sendGETRequest(url: NetworkConstants.Game.storyCompleteURL, parameters: [:], responseType: [Story].self) { (response, _) in
            completion(response ?? [])
        }
    }
    
    /// `GET` Status
    /// `returns` current status of enigma
    func getStatus(completion : @escaping (Bool,String)->()){
        WebHelper.sendGETRequest(url: NetworkConstants.Game.status, parameters: [:], responseType: Status.self,key: Keys.status) { (response, _) in
            let hasStarted = response?.started ?? false
            Defaults.setStarted(hasStarted)
            UserDefaults.standard.set(hasStarted, forKey: Keys.started)
            let startDate = response?.date ?? AppConstants.Date.startDate
            reloadWidget()
            completion(hasStarted,startDate)
        }
    }
    
}

//END
