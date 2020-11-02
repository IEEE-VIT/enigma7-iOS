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

extension HomeViewController : ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding
{
    
    
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return ASPresentationAnchor(frame: view.frame)
    }
    
    
    func appleSignin() {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        } else {
            appleAlert()
        }
    }
    
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let data = appleIDCredential.authorizationCode else { return }
            guard let code = String(data: data, encoding: .utf8) else { return }
            signinWithBackend(type: .apple, code: code)
        }
    }
    
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("ASAuthorizationController: ",error.localizedDescription)
    }
    
    func appleAlert(){
        
    }
}

