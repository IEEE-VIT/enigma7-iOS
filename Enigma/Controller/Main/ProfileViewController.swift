//
//  ProfileViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import Intents

protocol LogoutDelegate: class {
    func logout()
}

class ProfileViewController: UIViewController {
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var emailId: UILabel!
    @IBOutlet weak var questionsSolved: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var signoutButton: UIButton!
    
    weak var delegate: LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleUserDetails(details: Defaults.user())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ServiceController.shared.getUserDetails(completion: handleUserDetails(details:))
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signoutButton.addBorder(width: 2, .tertiary)
        bottomConstraint.constant = view.frame.height * 0.08
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.siriRequest()
    }
    
    func handleUserDetails(details: UserDetails?){
        guard let user = details else { return }
        username.text = user.username
        emailId.text = user.email
        questionsSolved.text = user.question_answered?.stringValue
        rank.text = user.rank?.stringValue
        score.text = user.points?.stringValue
    }
    
    @IBAction func logout(_ sender: Any) {
        PostController.shared.logout()
        self.delegate?.logout()
    }
    
    func siriRequest(){
        if enigmaStarted(){ INPreferences.requestSiriAuthorization { _ in}  }
    }
    
    fileprivate func enigmaStarted()->Bool{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        guard let hackOn = formatter.date(from: "2020/12/04 18:20") else {return false}
        return (hackOn < Date())
    }
    
}

