//
//  TimerController.swift
//  EnigmaWatch Extension
//
//  Created by Aaryan Kothari on 27/11/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import WatchKit

class TimerController: WKInterfaceController {
    
    
    @IBOutlet weak var timer: WKInterfaceTimer!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        timer.setDate(Date(timeIntervalSince1970: 1607079000))
        timer.start()
    }
    
}
