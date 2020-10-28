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
    
    ///VARIABLES
    weak var delegate : SigninDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        appleButton.addBorder(width:2, UIColor.quaternary, alpha:0.2)
        googleButton.addBorder(width:2, UIColor.quaternary, alpha:0.2)
    }
    
    @IBAction func signinWithApple(_ sender: UIButton) {
        appleSignin()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let userVC = segue.destination as? UserNameViewController{
            userVC.view.frame = self.view.frame
        }
    }
    
}
