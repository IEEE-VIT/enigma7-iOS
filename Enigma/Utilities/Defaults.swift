//
//  Defaults.swift
//  Enigma
//
//  Created by Aaryan Kothari on 08/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

class  Defaults {
    
    public static let userDefaults = UserDefaults.standard
    
    static func token() -> String {
        return userDefaults.string(forKey: Keys.token) ?? ""
    }
    

    static func user() -> UserDetails? {
        let body = userDefaults.value(forKey: Keys.user) as? Data
        guard let data = body else { return nil }
        return decode(data: data)
    }
    
}
