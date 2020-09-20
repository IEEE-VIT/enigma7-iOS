//
//  HomeViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import GoogleSignIn

class HomeViewController: UIViewController {
    
    ///OUTLETS
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!
    
    ///VARIABLES
    var instagramApi = InstagramApi.shared
    var testUserData = InstagramTestUser(access_token: "", user_id: 0)
    var instagramUser: InstagramUser?
    var signedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        appleButton.addBorder(width:2, UIColor.quaternary, alpha:0.2)
        googleButton.addBorder(width:2, UIColor.quaternary, alpha:0.2)
        instagramButton.addBorder(width:2, UIColor.quaternary, alpha:0.2)
    }
    
    @IBAction func signinWithApple(_ sender: UIButton) {
        appleSignin()
    }
    
    @IBAction func signinWithGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func signinWithInstagram(_ sender: UIButton) {
        
    }
    
    func signinWithBackend(type : SignupType, code : String){
        let request = SignupRequest(code: code, type: type)
        PostController.shared.signup(type: type, body: request) { (success, response, error) in
            //TODO
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let userVC = segue.destination as? UserNameViewController{
            userVC.view.frame = self.view.frame
        }
    }
    
}
