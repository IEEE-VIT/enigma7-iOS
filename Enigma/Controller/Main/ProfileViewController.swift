//
//  ProfileViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var emailId: UILabel!
    @IBOutlet weak var questionsSolved: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var profileTableView: UITableView!
    
    @IBOutlet weak var signoutButton: UIButton!
    
    var tableHeight : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signoutButton.addBorder(width: 2, .tertiary)
    }
    
    @IBAction func logout(_ sender: Any) {
        
    }
    
}
