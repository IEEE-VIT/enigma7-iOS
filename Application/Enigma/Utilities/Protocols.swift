//
//  Protocols.swift
//  Enigma
//
//  Created by Aaryan Kothari on 15/01/21.
//  Copyright © 2021 Aaryan Kothari. All rights reserved.
//

import UIKit

// MARK:- PROTOCOLS

/// SHARE DELEGATE
/// setShare: changes icon of info tab when true
protocol ShareDelegate : class {
    func setShare(bool : Bool, image: UIImage?)
}

/// LOGOUT DELEGATE
/// empties default and returns rootViewController
protocol LogoutDelegate: class {
    func logout()
}

/// SIGNIN DELEGATE
/// persists token and sends it to Watch.
protocol SigninDelegate: class {
    func didSignin(_ token: String)
}

/// COUNTDOWN DELEGATE
protocol CountdownDelegate: class {
    func didSignin(_ token: String)
}

/// PREVIEW DELEGATE
protocol PreviewDelegate : class {
    func hintPreviewed()
}


