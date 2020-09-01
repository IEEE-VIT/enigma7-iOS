//
//  Number.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

extension Int{
    var stringValue : String{
        return String(self)
    }
    
    var timeValue : String{
        let time = (stringValue.count == 1) ? "0"+stringValue : stringValue
        return time
    }
}
