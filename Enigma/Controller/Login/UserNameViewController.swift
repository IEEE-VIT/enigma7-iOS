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
    @IBOutlet weak var sourceTextField: CustomTextField!
    @IBOutlet weak var yearTextField: CustomTextField!
    @IBOutlet weak var graduateLabel: UILabel!
    @IBOutlet weak var studentSegmentedControl: UISegmentedControl!
    weak var CountdownController : CountdownViewController?
    
    let errorPrefix = AppConstants.Error.usernameErrorPrefix
    var error = String() {
        didSet {
            error = errorPrefix + error
           // errorTextView.text = error
        }
    }
    
    var isStudent: Bool {
        return studentSegmentedControl.selectedSegmentIndex == 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) { overrideUserInterfaceStyle = .light }
        studentSegmentedControl.selectedSegmentIndex = 1
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nextButton.addBorder(UIColor.tertiary)
        userNameTextField.setUI()
        sourceTextField.setUI()
        yearTextField.setUI()
    }
    
    
    @IBAction func nextTapped(_ sender: Any) {
        guard validate() == true else { return }
        let request = EditUsernameModel.Request(username: userNameTextField.text!)
        PostController.shared.editUserName(request, completion: handleEditusername(success:response:))
    }
    
    @IBAction func didTapSegment(_ sender: UISegmentedControl) {
        graduateLabel.isHidden = sender.selectedSegmentIndex == 1
        yearTextField.isHidden = sender.selectedSegmentIndex == 1
    }
    
    
    func handleEditusername(success: Bool, response: EditUsernameModel.Response?){
        if success{
            let body = OutreachModel.Request(outreach: sourceTextField.text!, is_college_student: isStudent, year: Int(yearTextField.text!) ?? 2020)
            PostController.shared.postOutreach(body){ _,_  in }
            ServiceController.shared.getStatus(completion: handleStatus(started:date:)) }
        else { self.error = response?.error ?? AppConstants.Error.misc}
    }
    
    func handleStatus(started:Bool,date:String){
      UserDefaults.standard.set(started, forKey: Keys.login)
      let viewcontroller = started ? AppConstants.ViewController.RulesViewController : AppConstants.ViewController.CountdownViewController
      present(viewcontroller)
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
        
        if sourceTextField.text?.isEmpty ?? true{
            error = AppConstants.Error.emptySource
            return false
        }
        
        if isStudent && yearTextField.text?.isEmpty ?? true{
            error = AppConstants.Error.emptyYear
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

