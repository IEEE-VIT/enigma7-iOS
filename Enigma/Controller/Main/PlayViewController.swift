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
    
    var previousTag : Int = 0
    
    let hint = "Vitae habitasse fames feugiat morbi."

    override func viewDidLoad() {
        super.viewDidLoad()
        for button in powerupButtons{
            setButton(button,false)
        }
        
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
        print("TAPPED")
      let headerView = HintAlert()
        self.addChild(headerView)
        self.view.addSubview(headerView.view)
        headerView.didMove(toParent: self)
        headerView.view.frame = self.view.frame
    }
    
    func showProgress(){
        let progress = xpBar(for: progressBar, duration: 2, startValue: 0.0, endValue: 0.5)
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
    
}
