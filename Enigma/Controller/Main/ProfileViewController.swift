//
//  ProfileViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import WebKit
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
    @IBOutlet weak var privacyLabel: UILabel!
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var privacyCard: UIView!
    weak var delegate: LogoutDelegate?
    var policyOn : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleUserDetails(details: Defaults.user())
        loadPrivacy()
        self.privacyLabel.underline()
        self.view.sendSubviewToBack(privacyCard)
        privacyCard.alpha = 0.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ServiceController.shared.getUserDetails(completion: handleUserDetails(details:))
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signoutButton.addBorder(width: 2, .tertiary)
        privacyCard.addBorder(width: 10, .primary, alpha: 0.8)
        bottomConstraint.constant = view.frame.height * 0.08
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.siriRequest()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if policyOn { self.dismissPrivacy((Any).self) }
    }
    
    func loadPrivacy(){
        guard let url = URL(string: AppConstants.privacy) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func handleUserDetails(details: UserDetails?){
        guard let user = details else { return }
        username.text = user.username
        emailId.text = user.email
        questionsSolved.text = user.question_answered?.stringValue
        rank.text = user.rank?.stringValue
        score.text = user.points?.stringValue
    
    }
    
    @IBAction func priavcyTapped(_ sender: Any) {
        print("privacy")
        self.view.bringSubviewToFront(privacyCard)
        self.policyOn = true
        privacyCard.alpha = 1.0
    }
    
    @IBAction func dismissPrivacy(_ sender: Any) {
        self.view.sendSubviewToBack(privacyCard)
        privacyCard.alpha = 0.0
        self.policyOn = false
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
        formatter.timeZone = TimeZone(abbreviation: "IST")
        formatter.locale = Locale(identifier: "en_US_POSIX")
        guard let hackOn = formatter.date(from: "2020/12/05 16:20") else {return false}
        return (hackOn < Date())
    }
    
}


extension UILabel {
    func underline() {
        if let textString = self.text {
          let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: attributedString.length))
          attributedText = attributedString
        }
    }
}
