//
//  PlayViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet var powerupButtons: [UIButton]!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var answerTextField: CustomTextField!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var subScrollView: UIView!
    var previousTag : Int = 0
        
    var startingImageFrame : CGRect?
    var backgroundView : ImageScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for button in powerupButtons{
            setButton(button,false)
        }
        submitButton.addBorder(width: 2, .tertiary)
        questionImageView.addBorder(width: 2, .tertiary)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showProgress()
        subscribeToKeyboardNotifications()
        progressBar.layer.borderWidth = 1.5
        progressBar.layer.borderColor = UIColor.secondary.cgColor
        questionImageView.image = UIImage(named: "sample")
        //ServiceController.shared.getQuestion(completion: handleQuestion(question:)) //TODO
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    @IBAction func submitTapped(_ sender: Any) {
        let width = UIScreen.main.bounds.width * 0.8
        let height = width / 3.33
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        let alert = AKAlert(type: .success)
        alert.frame = frame
        self.view.addSubview(alert)
        alert.center = self.view.center
    }
    
    
    @IBAction func powerupTapped(_ sender: UIButton) {
        let powerup = sender.tag
        let powerupButton = powerupButtons[powerup]
        
        setButton(powerupButtons[previousTag],false)
        setButton(powerupButton, true)
        
        self.previousTag = sender.tag
    }
    
    
    @IBAction func hintTapped(_ sender: Any) {
        createHintAlert()
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let _ = questionImageView.image else { return }
        self.performZoom()
    }
    
    func handleQuestion(question : Question?){
        guard  let question = question else { return }
        questionLabel.text = question.text
        questionImageView.asyncLoadImage(question.imageUrl, placeHolder: nil)
    }
    

    func showProgress(){
        let progress = xpBar(for: progressBar, duration: 1.5, startValue: 0.0, endValue: 0.6)
        self.progressBar.layer.insertSublayer(progress, above: self.progressBar.layer)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension PlayViewController : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 1) {
            let scrollPoint = CGPoint(x: 0, y: 80)
            //self.scroll.setContentOffset(scrollPoint, animated: true)
        }
    }
}



