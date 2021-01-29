//
//  Defaults.swift
//  Enigma
//
//  Created by Aaryan Kothari on 08/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation
import UIKit

//MARK: --- DEFAULTS: CONTROLLER FOR ALL USERDEFAULTS ---

class  Defaults {
    
    // shared group for common userdefaulst b/w ios app and widget
    public static let userDefaults = UserDefaults(suiteName: "group.widget.ak")
    
    static func token() -> String {
        let token = userDefaults?.string(forKey: "Token")
        userDefaults?.synchronize()
        return token ?? ""
    }
    
    static func isLoggedin() -> Bool {
        return (UserDefaults.standard.value(forKey: Keys.login) as? Bool) ?? false
    }
    
    static func startedWidget() -> Bool {
        let started = userDefaults?.bool(forKey: "started")
        userDefaults?.synchronize()
        return started ?? false
    }
    
    static func setStarted(_ bool : Bool){
        userDefaults?.set(bool, forKey: "started")
        userDefaults?.synchronize()
    }
    
    static func started() -> Bool {
        return (UserDefaults.standard.value(forKey: Keys.started) as? Bool) ?? false
    }
    
    static func enigmaStarted() -> Bool {
        return (UserDefaults.standard.value(forKey: Keys.enigmaStarted) as? Bool) ?? false
    }
    
    static func appOpenCount() -> Int {
        return (UserDefaults.standard.value(forKey: Keys.appOpenCount) as? Int) ?? 1
    }
    
    static func login(_ key : String){
        UserDefaults.standard.set("Token " + key, forKey: Keys.token)
        let defaults = UserDefaults(suiteName: "group.widget.ak")
        defaults?.set("Token " + key, forKey: "Token")
        defaults?.synchronize()
        reloadWidget()
    }

    static func user() -> UserDetails? {
        let body = userDefaults?.value(forKey: Keys.user) as? Data
        userDefaults?.synchronize()
        guard let data = body else { return nil }
        return decode(data: data)
    }
    
    static func username() -> String {
        return (UserDefaults.standard.value(forKey: Keys.username) as? String) ?? ""
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
        guard let data = body else { return nil }
        return decode(data: data)
    }
    
    static func hint() -> Hint? {
        let body = UserDefaults.standard.value(forKey: Keys.hint) as? Data
        guard let data = body else { return nil }
        return decode(data: data)
    }
    
    static func saveImage(_ data : Data?){
        guard let data = data else { return }
        userDefaults?.set(data, forKey: Keys.image)
        userDefaults?.synchronize()
    }
    
    static func fetchImage()->UIImage?{
        let data = userDefaults?.value(forKey: Keys.image) as? Data
        userDefaults?.synchronize()
        guard let img = data else { return nil }
        let image = UIImage(data: img)
        return image
    }
    
    static func status() -> Status? {
        let body = UserDefaults.standard.value(forKey: Keys.status) as? Data
        guard let data = body else { return nil }
        return decode(data: data)
    }
    
    //MARK: FETCH ALL
    static func fetchAll(){
        if Defaults.isLoggedin() {
        print("FETCHING ALL DATA")
        ServiceController.shared.getStory { (_) in }
        ServiceController.shared.getLeaderboard { (_) in }
        ServiceController.shared.getUserDetails { (_) in }
        ServiceController.shared.getFullStory { (_) in }
        ServiceController.shared.getStatus { (_,_)  in }
        }
    }
    
    //MARK: EMPTY ALL
    static func emptyAll(){
        print("EMPTYING ALL DATA")
        UserDefaults.standard.set(false, forKey: Keys.login)
        UserDefaults.standard.set(nil, forKey: Keys.token)
        UserDefaults.standard.set(nil, forKey: Keys.hint)
        UserDefaults.standard.set(nil, forKey: Keys.question)
        UserDefaults.standard.set(nil, forKey: Keys.user)
        UserDefaults.standard.set(nil, forKey: Keys.image)
        userDefaults?.set(nil, forKey: "Token")
        userDefaults?.synchronize()
        reloadWidget()
    }

}
