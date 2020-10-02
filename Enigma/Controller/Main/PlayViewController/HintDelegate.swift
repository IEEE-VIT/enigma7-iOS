//
//  HintDelegate.swift
//  Enigma
//
//  Created by Aaryan Kothari on 01/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

extension PlayViewController : AlertDelegate{
    func hintSkipped(type: HintAlert.AlertType) {
        if type != .normal{
            resetPowerups()
        }
    }
    
    func hintUsed(type: HintAlert.AlertType) {
        switch type {
        case .normal:
            ServiceController.shared.getHint(completion: handleHint(hint:))
        case .freeHint:
            ServiceController.shared.getHint(powerup: true, completion: handleHint(hint:))
        case .skipQuestion:
            PostController.shared.skipQuestion(completion: handleSkip(answer:))
        }
    }
    
    func handleHint(hint:Hint?){
        guard let text = hint?.hint else {
            let message = hint?.detail ?? "Error"
            presentAKAlert(type: .custom(message: message))
            return
        }
        hintLabel.isUserInteractionEnabled = false
        hintLabel.text = text
        hintLabel.textAlignment = .left
        resetPowerups()
        //TODO update xp
    }
    
    func createHintAlert(_ type : HintAlert.AlertType){
        let headerView = HintAlert()
        headerView.type = type
        headerView.modalPresentationStyle = .overFullScreen
        headerView.delegate = self
        self.present(headerView, animated: false, completion: nil)
    }
    
    func handleSkip(answer:AnswerResponse?){
        resetPowerups()
        ServiceController.shared.getQuestion(completion: handleQuestion(question:))
    }
    
    func resetPowerups(){
        closePowerupOn = false
        setButton(powerupButtons[previousTag],false)
    }
}
