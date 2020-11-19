//
//  HintDelegate.swift
//  Enigma
//
//  Created by Aaryan Kothari on 01/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

extension PlayViewController : AlertDelegate{
    func hintSkipped(type: HintAlert.AlertType) {
        type == .normal ? setBottomButton(hintButton, false) : resetPowerups()
    }
    
    func hintUsed(type: HintAlert.AlertType) {
        switch type {
        case .normal:
            ServiceController.shared.getHint(completion: handleHint(hint:))
        case .freeHint:
            ServiceController.shared.getHint(powerup: true, completion: handleHint(hint:))
        case .skipQuestion:
            PostController.shared.skipQuestion(completion: handleSkip(success:answer:))
        }
    }
    
    func handleHint(hint:Hint?){
        setBottomButton(hintButton, false)
        guard let text = hint?.hint else {
            setButton(powerupButtons[previousTag],false)
            let message = hint?.detail ?? AppConstants.Error.misc
            presentAKAlert(type: .custom(message: message))
            return
        }
        self.hint = hint?.hint ?? ""
        resetPowerups()
        updateProgressbar()
    }
    
    func resetHint(){
        answerTextField.text = ""
        self.hint = ""
        resetPowerups()
    }
    
    func loadHint(hint:Hint?){
        guard let text = hint?.hint else { return }
        self.hint = text
        resetPowerups()
    }
    
    func createHintAlert(_ type : HintAlert.AlertType){
        let headerView = HintAlert()
        headerView.type = type
        headerView.modalPresentationStyle = .overFullScreen
        headerView.delegate = self
        self.present(headerView, animated: false, completion: nil)
    }
    
    func handleSkip(success:Bool,answer:AnswerModel.Response?){
        updateProgressbar()
        if success {
            setButton(powerupButtons[previousTag],false)
            resetHint()
            UserDefaults.standard.set(nil, forKey: Keys.hint)
            ServiceController.shared.getQuestion(completion: handleQuestion(question:))
        } else {
            setButton(powerupButtons[previousTag],false)
            let message = answer?.detail ?? AppConstants.Error.misc
            presentAKAlert(type: .custom(message: message))
        }
    }
    
    func resetPowerups(){
        closePowerupOn = false
        setButton(powerupButtons[previousTag],false)
    }
}
