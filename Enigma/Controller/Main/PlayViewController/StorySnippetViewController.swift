//
//  StorySnippetViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 21/11/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class StorySnippetViewController: UIViewController {

    @IBOutlet weak var storyTextView: UITextView!
    
    var timer: Timer?

    var story: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateText()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.story = ""
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    func animateText(){
        storyTextView.text = ""
        var charIndex = 0.0
        for letter in story {
            let time = 0.1 * charIndex
            timer = Timer.scheduledTimer(withTimeInterval: time, repeats: false) { (_) in
                if self.timer != nil {
                self.storyTextView.text?.append(letter)
                }
            }
            charIndex += 1
        }
    }
    
}
