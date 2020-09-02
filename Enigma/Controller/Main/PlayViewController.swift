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
    
    var previousTag : Int = 0
    
    let hint = "Vitae habitasse fames feugiat morbi."

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
        progressBar.layer.borderWidth = 1.5
        progressBar.layer.borderColor = UIColor.secondary.cgColor
    }
    
    
    @IBAction func submitTapped(_ sender: Any) {
    }
    
    
    @IBAction func powerupTapped(_ sender: UIButton) {
        let powerup = sender.tag
        let powerupButton = powerupButtons[powerup]
        
        setButton(powerupButtons[previousTag],false)
        setButton(powerupButton, true)
        
        self.previousTag = sender.tag
    }
    
    
    @IBAction func hintTapped(_ sender: Any) {
        let headerView = HintAlert()
        headerView.modalPresentationStyle = .overFullScreen
        headerView.delegate = self
        self.present(headerView, animated: false, completion: nil)
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
            self.scroll.setContentOffset(scrollPoint, animated: true)
        }
    }
    
}

extension PlayViewController : AlertDelegate{
    func hintUsed() {
        hintLabel.isUserInteractionEnabled = false
        hintLabel.text = self.hint
        hintLabel.textAlignment = .left
    }
}

