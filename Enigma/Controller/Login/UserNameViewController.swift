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
    
    let errorPrefix = AppConstants.Error.usernameErrorPrefix
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
        userNameTextField.backgroundColor = #colorLiteral(red: 0.05169083923, green: 0.09415727109, blue: 0.06114685535, alpha: 1)
    }
    
    
    @IBAction func nextTapped(_ sender: Any) {
        guard validate() == true else { return }
        let request = EditUsernameModel.Request(username: userNameTextField.text!)
        PostController.shared.editUserName(request, completion: handleEditusername(success:response:))
    }
    
    func handleEditusername(success: Bool, response: EditUsernameModel.Response?){
        if success{ self.gotoTimer()  }
        else { self.error = response?.error ?? AppConstants.Error.misc}
    }
    
    func gotoTimer(){
        present(AppConstants.ViewController.CountdownViewController)
    }
    
    func validate()->Bool{
        if userNameTextField.text?.isEmpty ?? true{
            error = AppConstants.Error.emptyUsername
            return false
        }
        
        if userNameTextField.text?.hasSpecialCharacter ?? true{
            error = AppConstants.Error.specialCharacters
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
        }
    }
}

