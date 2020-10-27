//
//  PlayViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

protocol ShareDelegate : class {
    func setShare(bool : Bool, image: UIImage?)
}

class PlayViewController: UIViewController {
    
    
    @IBOutlet weak var xpLabel: UILabel!
    @IBOutlet weak var progressBar: xpBar!
    @IBOutlet var powerupButtons: [UIButton]!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var answerTextField: CustomTextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var subScrollView: UIView!
    
    
    var previousTag : Int = 0
    var image : UIImage?
    var startingImageFrame : CGRect?
    var closePowerupOn : Bool = false
    var backgroundView : ImageScrollView!
    weak var delegate : ShareDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in powerupButtons{
            setButton(button,false)
        }
        loadHint(hint: Defaults.hint())
        handleQuestion(question: Defaults.question())
        ServiceController.shared.getQuestion(completion: handleQuestion(question:))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        submitButton.addBorder(width: 2, .tertiary)
        hintButton.addBorder(width: 2, .tertiary)
        questionImageView.addBorder(width: 2, .tertiary)
        answerTextField.backgroundColor = #colorLiteral(red: 0.05169083923, green: 0.09415727109, blue: 0.06114685535, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        subscribeToKeyboardNotifications()
        updateProgressbar()
        answerTextField.layer.borderColor = UIColor.black.cgColor
        //  ServiceController.shared.getQuestion(completion: handleQuestion(question:))
        //showsTouchWhenHighlighted = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    @IBAction func submitTapped(_ sender: Any) {
        guard validate() else { return }
        setBottomButton(submitButton, true)
        let answer = AnswerModel.Request(answer: answerTextField.text ?? "")
        PostController.shared.answerQuestion(answer, closePowerupUsed: closePowerupOn, completion: handleAnswerResponse(success:close:message:))
    }
    
    
    @IBAction func hintTapped(_ sender: UIButton) {
        setBottomButton(hintButton, true)
        createHintAlert(.normal)
    }
    
    func validate()->Bool{
        if answerTextField.text?.isEmpty ??  true {
            presentAKAlert(type: .custom(message: "Answer can not be empty!"))
            return false
        }
        return true
    }
    
    
    
    func handleAnswerResponse(success:Bool,close:Bool,message:String){
        setBottomButton(submitButton, false)
        if success{
            presentAKAlert(type: .success)
            processCorrectAnswer()
        } else if close {
            presentAKAlert(type: .close)
        } else {
            if closePowerupOn {
                presentAKAlert(type: .custom(message: message))
            } else {
                presentAKAlert(type: .failure)
            }
        }
    }
    
    func presentAKAlert(type: AKAlert.ALertType){
        let width = UIScreen.main.bounds.width * 0.8
        let height = width / 3.33
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        let alert = AKAlert(type: type)
        alert.frame = frame
        self.view.addSubview(alert)
        alert.center = self.view.center
    }
    
    func processCorrectAnswer(){
        self.questionLabel.text = ""
        self.answerTextField.text = ""
        self.questionImageView.image = nil
        UserDefaults.standard.set(nil, forKey: Keys.question)
        UserDefaults.standard.set(nil, forKey: Keys.hint)
        updateProgressbar()
        resetPowerups()
        resetHint()
        ServiceController.shared.getQuestion(completion: handleQuestion(question:))
    }
    
    @IBAction func powerupTapped(_ sender: UIButton) {
        let powerup = sender.tag
        let powerupButton = powerupButtons[powerup]
        
        setButton(powerupButtons[previousTag],false)
        setButton(powerupButton, true)
        
        if powerup == 1 && closePowerupOn{
            closePowerupOn = false
            setButton(powerupButtons[1],false)
        } else {
            closePowerupOn = sender.tag == 1
        }
        
        if sender.tag == 0{
            createHintAlert(.freeHint)
        } else if sender.tag == 2{
            createHintAlert(.skipQuestion)
        }
        
        
        self.previousTag = sender.tag
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let _ = questionImageView.image else { return }
        self.performZoom()
    }
    
    func handleQuestion(question : Question?){
        guard  let question = question else { return }
        questionLabel.text = question.text
        questionNumberLabel.text = question.questionNumber
        questionImageView.asyncLoadImage(question.imageUrl, placeHolder: nil, img: setImage(img:))
    }
    
    func setImage(img: UIImage){
        self.image = img
    }
    
    func setButton(_ button : UIButton ,_ bool : Bool){
        if !bool {
            button.addBorder(width: 1, .quaternary, alpha: 0.2)
            button.backgroundColor = .clear
        } else{
            button.addBorder(.quaternary)
            button.backgroundColor = UIColor.primary.withAlphaComponent(0.6)
        }
    }
    
    func setBottomButton(_ button : UIButton ,_ bool : Bool){
        let color : UIColor = bool ? UIColor.primary.withAlphaComponent(0.6) : .clear
        button.backgroundColor = color
        button.isEnabled = !bool
    }
    
    func updateProgressbar(){
        let progress = Defaults.xp() / maxXp
        print(Defaults.xp(),maxXp,progress)
        progressBar.animateProgress(toPercent: CGFloat(progress))
        xpLabel.text = Int(Defaults.xp()).stringValue + "px"
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
