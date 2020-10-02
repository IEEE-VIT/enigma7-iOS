//
//  HintDelegate.swift
//  Enigma
//
//  Created by Aaryan Kothari on 01/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

extension PlayViewController : AlertDelegate{
    func hintUsed(type: HintAlert.AlertType) {
        switch type {
        case .normal:
            ServiceController.shared.getHint(completion: handleHint(hint:))
        case .freeHint:
            print("free")
        case .skipQuestion:
            print("SKIP")
        }
    }
    
    func handleHint(hint:Hint?){
        guard let hint = hint else { return }
        hintLabel.isUserInteractionEnabled = false
        hintLabel.text = hint.hint
        hintLabel.textAlignment = .left
    }
    
    func createHintAlert(_ type : HintAlert.AlertType){
        let headerView = HintAlert()
        headerView.type = type
        headerView.modalPresentationStyle = .overFullScreen
        headerView.delegate = self
        self.present(headerView, animated: false, completion: nil)
    }
}
