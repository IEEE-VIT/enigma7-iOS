//
//  InterfaceController.swift
//  EnigmaWatch Extension
//
//  Created by Aaryan Kothari on 21/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity



class InterfaceController: WKInterfaceController {
    
    var wcSession : WCSession!


    override func awake(withContext context: Any?) {
        // Configure interface objects here.

    }
    
    override func willActivate() {
        super.willActivate()
        wcSession = WCSession.default
                wcSession.delegate = self
                wcSession.activate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
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


extension InterfaceController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
         let token = message["token"] as! String
         print(token)
        UserDefaults.standard.setValue("Token "+token, forKey: "token")
     }
}
