//
//  Answer Response.swift
//  Enigma
//
//  Created by Aaryan Kothari on 01/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct AnswerResponse: Decodable {
    let answer : Bool?
    let detail : String?
}
