//
//  Signup.swift
//  Enigma
//
//  Created by Aaryan Kothari on 08/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct SignupRequest : Encodable {
    let code : String
    let callback_url : String
    
    init(code: String,type : SignupType){
        self.code = code
        self.callback_url = type.callback
    }
}

enum SignupType : String{
    case google
    case apple
    case instagram
    
    var url : String {
        switch self {
        case .google:
            return NetworkConstants.Users.googleURL
        case .apple:
            return NetworkConstants.Users.appleURL
        case .instagram:
            return NetworkConstants.Users.instagramURL
        }
    }
    
    var callback : String {
        switch self {
        case .google:
            return "http://127.0.0.1:8000/"
        case .apple:
            return "TODO"
        case .instagram:
            return "https://127.0.0.1:8000/"
        }
    }
}
