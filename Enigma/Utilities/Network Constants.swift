//
//  NetworkConstants.swift
//  Enigma
//
//  Created by Aaryan Kothari on 08/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct NetworkConstants {
    
    public static let baseURL = "https://enigma7-backend.herokuapp.com/"
    
    public static let googleURL = baseURL + "api/v1/users/auth/google/"
    public static let appleURL = baseURL + "api/v1/users/auth/apple/"
    public static let instagramURL = baseURL + "api/v1/users/auth/instagram/"
    
}


