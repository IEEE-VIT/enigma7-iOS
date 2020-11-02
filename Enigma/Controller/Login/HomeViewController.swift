//
//  HomeViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import GoogleSignIn

protocol SigninDelegate: class {
    func didSignin(_ token: String)
}

class HomeViewController: UIViewController {
    
    ///OUTLETS
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var enigmaTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var enigmaCentreAnchor: NSLayoutConstraint!
    ///VARIABLES
    weak var delegate : SigninDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleSetup()
        launchScreenInitialSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        appleButton.addBorder(width:2, UIColor.quaternary, alpha:0.2)
        googleButton.addBorder(width:2, UIColor.quaternary, alpha:0.2)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     //   viewDidAppearSetup()
    }
    
    @IBAction func signinWithApple(_ sender: UIButton) {
        if #available(iOS 13, *) {
            appleSignin()
        } else {
            // TODO:- add alert for iOS 12.
        }
    }
    
    @IBAction func signinWithGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func signinWithBackend(type : SignupType, code : String){
        let request = SignUpModel.Request(code: code, type: type)
        PostController.shared.signup(type: type, body: request, completion: handleSignup(success:response:))
    }
    
    func handleSignup(success:Bool,response:SignUpModel.Response?){
        if success{
            let usernameExists = response?.username_exists ?? false
            guard usernameExists else { self.present(AppConstants.ViewController.UserNameViewController) ; return }
            delegate?.didSignin(response?.key ?? "")
            Defaults.fetchAll()
        } else {
            PostController.shared.logout()
        }
    }
    
    
    func launchScreenInitialSetup(){
        appleButton.alpha = 0.0
        googleButton.alpha = 0.0
        backdropImage.alpha = 0.0
        enigmaTopAnchor.priority = UILayoutPriority(1)
        enigmaCentreAnchor.priority = UILayoutPriority(999)
        enigmaCentreAnchor.constant = cc()
    }
    
    func viewDidAppearSetup(){
        enigmaTopAnchor.priority = UILayoutPriority(999)
        enigmaCentreAnchor.priority = UILayoutPriority(1)
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        } completion: { (_) in
            UIView.animate(withDuration: 0.5) { [self] in
                appleButton.alpha = 1.0
                googleButton.alpha = 1.0
                backdropImage.alpha = 1.0
            }
        }
    }
    
    func cc()->CGFloat{
        let bottom = (UIScreen.main.bounds.height * 0.133 + 10)
        let top : CGFloat = 62
        print("HEIG: ",(bottom - top)/2 - 50 )
        return (bottom - top)/2 - 50
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let userVC = segue.destination as? UserNameViewController{
            userVC.view.frame = self.view.frame
        }
    }
    
}
