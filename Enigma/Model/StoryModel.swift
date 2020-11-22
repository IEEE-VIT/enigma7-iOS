//
//  StoryModel.swift
//  Enigma
//
//  Created by Aaryan Kothari on 20/11/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct Story: Codable {
    var id : Int?
    var story : StoryObject?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case story = "question_story"
    }
}

struct StoryObject: Codable{
    var text: String
    enum CodingKeys: String, CodingKey {
        case text = "story_text"
    }
}

struct Stories: Codable {
    var stories : [Story]?
}
