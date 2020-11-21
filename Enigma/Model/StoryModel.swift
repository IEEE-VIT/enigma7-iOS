//
//  StoryModel.swift
//  Enigma
//
//  Created by Aaryan Kothari on 20/11/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct Story: Decodable {
    let id : Int?
    let story : StoryObject?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case story = "question_story"
    }
}

struct StoryObject: Decodable{
    var text: String
    enum CodingKeys: String, CodingKey {
        case text = "story_text"
    }
}

struct Stories: Decodable {
    let stories : [Story]?
}
