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
        let serverClientId = "55484635453-c46tes445anbidhb2qnmb2qs618mvpni.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().clientID = clientId
        GIDSignIn.sharedInstance()?.serverClientID = serverClientId
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
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
        print("URL",url)
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        print("URL",url)
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        print(error.localizedDescription)
    }
}
