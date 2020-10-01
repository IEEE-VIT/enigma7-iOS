//
//  Question Response.swift
//  Enigma
//
//  Created by Aaryan Kothari on 01/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct Question : Decodable {
    var imageUrl : String?
    var question : String?
    
    enum CodingKeys: String, CodingKey {
        case question = "text"
        case imageUrl = "img_url"
    }
}
