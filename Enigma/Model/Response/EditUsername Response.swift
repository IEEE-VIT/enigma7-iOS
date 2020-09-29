//
//  EditUsername Response.swift
//  Enigma
//
//  Created by Aaryan Kothari on 29/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct EditUsernameResponse : Decodable {
    let id : Int?
    let username : String?
    let error : String?
}
