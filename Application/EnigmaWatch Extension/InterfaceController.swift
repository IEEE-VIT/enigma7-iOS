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
        pushController("play")
    }
    
    
    @IBAction func leaderboardTapped() {
        pushController("leader")
    }
    
    @IBAction func profileTapped() {
        pushController("profile")
    }
    
    
    @IBAction func storyTapped() {
        pushController(withName: "rules", context: nil)
    }
    
    func token()->String{
       return UserDefaults.standard.string(forKey: "token") ?? ""
    }
    
    func pushController(_ name: String){
        if token() != ""{
            self.started(name)
        } else {
            let okay = WKAlertAction(title: "Okay", style: .default) { }
            presentAlert(withTitle: "Uh oh !😕", message: "Looks like you are not logged into the app. Please login the iOS app and tap the [i] icon on the top to continue.", preferredStyle: .alert, actions: [okay])
        }
    }
    
    func started(_ name:String){
        ServiceController.shared.getStatus { (started, _) in
            if started{
                self.pushController(withName: name, context: nil)
            } else {
                let date = Date(timeIntervalSince1970: 1607079000)
                print(date)
                let started = Date() > date
                let vc = started ? name : "timer"
                self.pushController(withName: vc, context: nil)
            }
        }
    }

    
}


extension InterfaceController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        guard let token = message["token"] as? String else { return }
        print(token)
        UserDefaults.standard.set(token, forKey: "token")
     }
}
