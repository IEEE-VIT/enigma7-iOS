//
//  Hint Response.swift
//  Enigma
//
//  Created by Aaryan Kothari on 01/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct Hint : Decodable{
    let hint : String?
    let status: Bool?
    let xp : Int?
}
