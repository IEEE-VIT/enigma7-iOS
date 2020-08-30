//
//  UserNameViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class UserNameViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var errorTextView: UITextView!
    
    let errorPrefix = "________________\nInvalidUsername.\n-> "
    var error = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.addBorder(UIColor.tertiary)
    }
    
    
    @IBAction func nextTapped(_ sender: Any) {
        errorTextView.isHidden = validate()
        if validate() {
            
        } else {
            errorTextView.text = error
        }
    }
    
    func validate()->Bool{
        if errorTextView.text.rangeOfCharacter(from: .decimalDigits) != nil {
            error = errorPrefix + "Numerals Missing!"
            return false
        }
        return true
    }
    
}

