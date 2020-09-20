//
//  Instagram Signin.swift
//  Enigma
//
//  Created by Aaryan Kothari on 20/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

extension HomeViewController {
    
    func InstagramSignin() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let webVC = storyBoard.instantiateViewController(withIdentifier: "WebView") as! WebViewController
        webVC.instagramApi = self.instagramApi
        webVC.mainVC = self
        self.present(webVC, animated:true)
    }
    
    
}
