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
    @IBOutlet weak var graduateLabel: UILabel!
    @IBOutlet weak var studentSegmentedControl: UISegmentedControl!
    weak var CountdownController : CountdownViewController?
    @IBOutlet weak var dropDownButton: UIButton!
    
    @IBOutlet weak var sourcePicker: UIPickerView!
    @IBOutlet weak var yearPicker: UISegmentedControl!
    
    @IBOutlet weak var pickerTop: UIView!
    let errorPrefix = AppConstants.Error.usernameErrorPrefix
    var error = String() {
        didSet {
            error = errorPrefix + error
           // errorTextView.text = error
        }
    }
    
    var graduationYear : Int = 2020
    
    var isStudent: Bool {
        return studentSegmentedControl.selectedSegmentIndex == 0
    }
    
    var sourceList = ["Reddit","Facebook","Instagram","Word of Mouth"]
    
    var editFrame = CGAffineTransform()
    var frame = CGRect()
    var cardOpen : Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) { overrideUserInterfaceStyle = .light }
        studentSegmentedControl.selectedSegmentIndex = 1
        self.didTapSegment(studentSegmentedControl)
        editFrame = sourcePicker.transform
        sourcePicker.layer.borderColor = UIColor.tertiary.cgColor
        sourcePicker.layer.borderWidth = 1.0
        sourcePicker.alpha = 0.0
        pickerTop.alpha = 0.0
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        groupToolBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nextButton.addBorder(UIColor.tertiary)
        userNameTextField.setUI()
        sourceTextField.setUI()
        frame = sourcePicker.frame
        sourcePicker.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: 0.0)
    }
    
    
    @IBAction func nextTapped(_ sender: Any) {
        guard validate() == true else { return }
        let request = EditUsernameModel.Request(username: userNameTextField.text!)
        PostController.shared.editUserName(request, completion: handleEditusername(success:response:))
    }
    
    @IBAction func didTapSegment(_ sender: UISegmentedControl) {
        graduateLabel.isHidden = sender.selectedSegmentIndex == 1
        yearPicker.isHidden = sender.selectedSegmentIndex == 1
    }
    
    
    @IBAction func graduationYear(_ sender: UISegmentedControl) {
        graduationYear = sender.selectedSegmentIndex + 2020
    }
    
    
    @IBAction func dropDown(_ sender: Any) {
        cardOpen ? closeCard() : openCard()
        cardOpen.toggle()
    }
    
    func openCard(){
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.dropDownButton.transform = CGAffineTransform(rotationAngle: .pi/2)
            self.sourcePicker.frame = self.frame
            self.sourcePicker.alpha = 1
            self.pickerTop.alpha = 1
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func closeCard(){
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.dropDownButton.transform = .identity
            self.sourcePicker.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: 0.0)
            self.sourcePicker.alpha = 0.0
            self.pickerTop.alpha = 0.0
            self.view.layoutIfNeeded()
        }, completion: { (true) in
            self.sourceTextField.resignFirstResponder()
        })
    }
    
    
    func handleEditusername(success: Bool, response: EditUsernameModel.Response?){
        if success{
            let body = OutreachModel.Request(outreach: sourceTextField.text!, is_college_student: isStudent, year: graduationYear)
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == sourceTextField {
            return false
        }
        
        return true
    }
    
}

extension UserNameViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func groupToolBar(){
        sourcePicker.showsSelectionIndicator = true
        sourcePicker.delegate = self
        sourcePicker.dataSource = self
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sourceList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = sourceList[row]
        return NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.tertiary])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let title = sourceList[row]
        sourceTextField.text = title
    }

}

