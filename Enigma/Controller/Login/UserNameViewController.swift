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
    var error = String() {
        didSet {
            error = errorPrefix + error
            errorTextView.text = error
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nextButton.addBorder(UIColor.tertiary)
    }
    
    
    @IBAction func nextTapped(_ sender: Any) {
        guard validate() == true else { return }
        let request = EditUsernameRequest(username: userNameTextField.text!)
        PostController.shared.editUserName(request, completion: handleEditusername(success:response:))
    }
    
    func handleEditusername(success: Bool, response: EditUsernameResponse?){
        if success{ self.gotoTimer()  }
        else { self.error = response?.error ?? "Error"}
    }
    
    func gotoTimer(){
        present("CountdownViewController")
    }
    
    func validate()->Bool{
        if userNameTextField.text?.isEmpty ?? true{
            error = "Username Empty!"
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
            print(textField.text ?? "YO")
        }
    }
}

