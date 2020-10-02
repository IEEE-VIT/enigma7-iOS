//
//  Question Response.swift
//  Enigma
//
//  Created by Aaryan Kothari on 01/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct Question : Decodable {
    var id : Int?
    var imageUrl : String?
    var text : String?
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case imageUrl = "img_url"
        case id = "id"
    }
    
    var questionNumber : String{
        return "Q" + (id ?? 1).stringValue + "."
    }
}
