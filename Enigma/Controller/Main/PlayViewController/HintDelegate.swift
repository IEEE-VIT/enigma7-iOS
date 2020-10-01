//
//  HintDelegate.swift
//  Enigma
//
//  Created by Aaryan Kothari on 01/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

extension PlayViewController : AlertDelegate{
    func hintUsed() {
        ServiceController.shared.getHint(completion: handleHint(hint:))
    }
    
    func handleHint(hint:Hint?){
        guard let hint = hint else { return }
        hintLabel.isUserInteractionEnabled = false
        hintLabel.text = hint.hint
        hintLabel.textAlignment = .left
    }
    
    func createHintAlert(){
        let headerView = HintAlert()
        headerView.modalPresentationStyle = .overFullScreen
        headerView.delegate = self
        self.present(headerView, animated: false, completion: nil)
    }
}
