//
//  HomeViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    ///OUTLETS
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        appleButton.addBorder(width:2, UIColor.quaternary, alpha:0.2)
        googleButton.addBorder(width:2, UIColor.quaternary, alpha:0.2)
    }
    
    @IBAction func signinWithApple(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let viewController  = storyboard.instantiateViewController(identifier: "UserNameViewController")
        viewController.view.frame = self.view.bounds
           viewController.view.layer.cornerRadius = 4
           viewController.view.layer.borderWidth = 3
           viewController.view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        self.view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    @IBAction func signinWithGoogle(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let userVC = segue.destination as? UserNameViewController{
            userVC.view.frame = self.view.frame
        }
    }
    
}
