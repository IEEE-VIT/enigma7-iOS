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
        let clientId = "55484635453-2fmn476nlr2it49soaejbeqj29lq0k6k.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().clientID = clientId
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            //TODO
            //self.removeBlurView()
            //self.activityView.stopAnimating()
            return
        }
        
        let userId = user.userID
        let idToken = user.authentication.idToken
        
        print("userId:",userId)
        print("token:",idToken)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
      // ...
    }
}
