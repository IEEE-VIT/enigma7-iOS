//
//  ProfileController.swift
//  EnigmaWatch Extension
//
//  Created by Aaryan Kothari on 21/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import WatchKit

class ProfileController: WKInterfaceController {
    
    
    @IBOutlet weak var userNameLabel: WKInterfaceLabel!
    @IBOutlet weak var emailLabel: WKInterfaceLabel!
    @IBOutlet weak var rankLabel: WKInterfaceLabel!
    @IBOutlet weak var scoreLabel: WKInterfaceLabel!
    @IBOutlet weak var qSolvedLabel: WKInterfaceLabel!
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        ServiceController.shared.getUserDetails(completion: handleUserDetails(user:))
    }
    
    func handleUserDetails(user:UserDetails?){
        guard let user = user else { return }
        userNameLabel.setText(user.username)
        emailLabel.setText(user.email)
        rankLabel.setText(user.rank?.stringValue)
        scoreLabel.setText(user.points?.stringValue)
        qSolvedLabel.setText(user.question_answered?.stringValue)
    }
    
    
    override func willActivate() {
        super.willActivate()
        handleUserDetails(user: Defaults.user())
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    
}

