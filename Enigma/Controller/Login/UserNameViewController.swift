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
            gotoTimer()
        } else {
            errorTextView.text = error
        }
    }
    
    func gotoTimer(){
        let viewController  = storyBoard.instantiateViewController(identifier: "CountdownViewController")
            viewController.view.frame = self.view.bounds
               viewController.view.layer.cornerRadius = 4
               viewController.view.layer.borderWidth = 3
               viewController.view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
            
            viewController.willMove(toParent: self)
            self.view.addSubview(viewController.view)
            self.addChild(viewController)
            viewController.didMove(toParent: self)
    }
    
    func validate()->Bool{
        if errorTextView.text.rangeOfCharacter(from: .decimalDigits) != nil {
            error = errorPrefix + "Numerals Missing!"
            return false
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension UserNameViewController : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text != ""{
            nextButton.isHidden = false
            print(textField.text)
        }
    }
}

