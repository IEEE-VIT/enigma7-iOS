//
//  Apple Signin.swift
//  Enigma
//
//  Created by Aaryan Kothari on 20/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation
import AuthenticationServices
import CryptoKit

//MARK: --- EXTENSION TO HANDLE APPLE AUTH ---

extension HomeViewController : ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding
{
    
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return ASPresentationAnchor(frame: view.frame)
    }
    
    @available(iOS 13.0, *)
    func appleSignin() {
        // initial setup
        self.appleButton.isEnabled = false
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.email]
        
        // setup authorization Controller
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    
    // AUTH SUCCESS
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let data = appleIDCredential.authorizationCode else { return }
            guard let code = String(data: data, encoding: .utf8) else { return }
            guard let authData = appleIDCredential.identityToken else { return }
            guard let authCode = String(data: authData, encoding: .utf8) else { return }
            signinWithBackend(type: .apple, code: code, token: authCode)
        }
    }
    
    // AUTH ERROR
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("ASAuthorization Error: ",error.localizedDescription)
        self.appleButton.isEnabled = true
    }
    
}

