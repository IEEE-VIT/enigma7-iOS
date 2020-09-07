//
//  Google+Signin.swift
//  Enigma
//
//  Created by Aaryan Kothari on 07/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import GoogleSignIn

extension HomeViewController: GIDSignInDelegate {
    public func googleSetup(){
        let clientId ="55484635453-2fmn476nlr2it49soaejbeqj29lq0k6k.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().clientID = clientId
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
    }
}
