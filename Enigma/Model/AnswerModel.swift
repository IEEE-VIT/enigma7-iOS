//
//  AnswerModel.swift
//  Enigma
//
//  Created by Aaryan Kothari on 07/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

final class AnswerModel {
    
    struct Request: Encodable{
        var answer : String
    }
    
    struct Response: Decodable {
        let answer : Bool?
        let close_answer : Bool?
        let detail : String?
        let question_id : Int?
        let status : Bool?
        let xp : Int?
    }
}
