//
//  InterfaceController.swift
//  EnigmaWatch Extension
//
//  Created by Aaryan Kothari on 21/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        let defaults = UserDefaults(suiteName: "group.widget.ak")
        let t = defaults?.value(forKey: "Token")
        defaults?.synchronize()
        print("Token:", t)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

    @IBAction func playTapped() {
        print("PLAY")
    }
    
    
    @IBAction func leaderboardTapped() {
    }
    
    @IBAction func profileTapped() {
    }
    
    
    @IBAction func storyTapped() {
    }
    
}
