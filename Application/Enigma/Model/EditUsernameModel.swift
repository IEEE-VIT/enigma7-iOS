//
//  EditUsernameModel.swift
//  Enigma
//
//  Created by Aaryan Kothari on 08/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

final class EditUsernameModel {
    
    struct Request : Encodable {
        let username : String
    }
    
    struct Response : Decodable {
        let id : Int?
        let username : String?
        let error : String?
    }
    
}
