//
//  Defaults.swift
//  Enigma
//
//  Created by Aaryan Kothari on 08/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation
import UIKit

class  Defaults {
    
    public static let userDefaults = UserDefaults(suiteName: "group.widget.ak")
    
    static func token() -> String {
        let token = userDefaults?.string(forKey: "Token")
        userDefaults?.synchronize()
        return token ?? ""
    }
    
    static func isLoggedin() -> Bool {
        return (UserDefaults.standard.value(forKey: Keys.login) as? Bool) ?? false
    }

    static func user() -> UserDetails? {
        let body = userDefaults?.value(forKey: Keys.user) as? Data
        userDefaults?.synchronize()
        guard let data = body else { return nil }
        return decode(data: data)
    }
    
    static func xp() -> Double {
        return (UserDefaults.standard.value(forKey: Keys.xp) as? Double) ?? 0.0
    }
        
    static func leaderboard() -> [Leaderboard]? {
        let body = userDefaults?.value(forKey: Keys.leaderboard) as? Data
        userDefaults?.synchronize()
        guard let data = body else { return nil }
        return decode(data: data)
    }
    
    static func question() -> Question? {
        let body = userDefaults?.value(forKey: Keys.question) as? Data
        userDefaults?.synchronize()
        print(body,"BODY")
        guard let data = body else { return nil }
        return decode(data: data)
    }
    
    static func hint() -> Hint? {
        let body = UserDefaults.standard.value(forKey: Keys.hint) as? Data
        guard let data = body else { return nil }
        return decode(data: data)
    }
    
    static func saveImage(_ data : Data?,question:Int){
        guard let data = data else { return }
        guard question != 0 else { return }
        userDefaults?.set(data, forKey: Keys.image + question.stringValue)
        userDefaults?.synchronize()
    }
    
    static func fetchImage(q:Int)->UIImage?{
        let data = userDefaults?.value(forKey: Keys.image + q.stringValue) as? Data
        userDefaults?.synchronize()
        guard let img = data else { return nil }
        let image = UIImage(data: img)
        return image
    }
    
    static func fetchAll(){
        if Defaults.isLoggedin() {
        print("FETCHING ALL DATA")
        ServiceController.shared.getLeaderboard { (_) in }
        ServiceController.shared.getUserDetails { (_) in }
        ServiceController.shared.getQuestion { (_) in }
        }
    }
    
}
