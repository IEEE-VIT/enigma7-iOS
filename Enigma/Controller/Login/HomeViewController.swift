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
        Haptic.hapticFeedback(.haptic(.success))
        present("UserNameViewController")
    }
    
    @IBAction func signinWithGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let userVC = segue.destination as? UserNameViewController{
            userVC.view.frame = self.view.frame
        }
    }
    
}
