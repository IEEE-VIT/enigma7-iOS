//
//  Error.swift
//  Enigma
//
//  Created by Aaryan Kothari on 08/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}

extension ErrorResponse: LocalizedError {
    var errorDescription: String? {
        return statusMessage
    }
}

struct sample : Decodable { }
