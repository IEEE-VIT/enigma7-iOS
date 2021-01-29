//
//  String.swift
//  Enigma
//
//  Created by Aaryan Kothari on 28/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

//MARK: Extension for String

extension String {
    // check for special character
    // used for username
    var hasSpecialCharacter : Bool {
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        return self.rangeOfCharacter(from: characterset.inverted) != nil
    }
}
