//
//  NetworkConstants.swift
//  Enigma
//
//  Created by Aaryan Kothari on 08/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct NetworkConstants {
    
    struct Users {
        public static let baseURL = "https://enigma7-backend.herokuapp.com/api/v1/users/"
        
        public static let googleURL = baseURL + "auth/google/"
        public static let appleURL = baseURL + "auth/apple/"
        public static let instagramURL = baseURL + "auth/instagram/"
        
        public static let editUsernameURL = baseURL + "me/edit/"
        public static let userDetailsURL = baseURL + "me/"
        public static let logoutURL = baseURL + "logout/"

    }
    
}


