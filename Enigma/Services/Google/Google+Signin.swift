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
        GIDSignIn.sharedInstance().clientID = AppConstants.Google.clientId
        GIDSignIn.sharedInstance()?.serverClientID = AppConstants.Google.serverClientId
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signOut()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            //TODO
            return
        }
        signinWithBackend(type:.google, code:user.serverAuthCode)
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
        print(error.localizedDescription)
    }
}
