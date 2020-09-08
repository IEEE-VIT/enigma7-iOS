//
//  Signup Response.swift
//  Enigma
//
//  Created by Aaryan Kothari on 08/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct SignupResponse : Decodable {
    var key : String?
    var username_exists : Bool?
}
