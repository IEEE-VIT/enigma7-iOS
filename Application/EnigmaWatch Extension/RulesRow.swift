//
//  RulesRow.swift
//  EnigmaWatch Extension
//
//  Created by Aaryan Kothari on 27/11/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import WatchKit

class RulesRow: NSObject {

    @IBOutlet weak var rule: WKInterfaceLabel!
    
    
    var text : String = "" {
        didSet{
            rule.setText(text)
        }
    }
    
}
