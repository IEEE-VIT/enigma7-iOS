//
//  PlayController.swift
//  EnigmaWatch Extension
//
//  Created by Aaryan Kothari on 21/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import WatchKit

class PlayController: WKInterfaceController {
    
    @IBOutlet weak var questionNumber: WKInterfaceLabel!
    @IBOutlet weak var question: WKInterfaceLabel!
    @IBOutlet weak var image: WKInterfaceImage!
    
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        ServiceController.shared.getQuestion(completion: handleQuestion(question:))
    }
    
    func handleQuestion(question:Question?){
        guard let question = question else { return }
        questionNumber.setText(question.questionNumber)
        self.question.setText(question.text)
        image.setBackgroundImage(url: question.imageUrl)
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    @IBAction func didClickAnswer() {
        let okay = WKAlertAction(title: "Okay", style: .default) { }
        presentAlert(withTitle: "Uh oh !😕", message: "This action can only be perfomed in ths iOS app.", preferredStyle: .alert, actions: [okay])
    }
}
