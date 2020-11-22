//
//  OutreachModel.swift
//  Enigma
//
//  Created by Aaryan Kothari on 23/11/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

final class OutreachModel {
    
    struct Request : Encodable {
        let outreach : String
        let is_college_student : Bool
        let year : Int
    }
    
    struct Response : Decodable {
        var user : Int?
        var outreach : String?
        var is_college_student : Bool?
        var year : Int?
    }
    
}
