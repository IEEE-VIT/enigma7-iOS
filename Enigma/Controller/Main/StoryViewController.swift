//
//  StoryViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {
    
    @IBOutlet weak var storyTextView: UITextView!
    
    let story = "Imperdiet vitae praesent ultrices libero tincidunt magna.\n\nImperdiet vitae praesent ultrices libero tincidunt magna.\n\nImperdiet vitae praesent ultrices libero tincidunt magna.\n\nImperdiet vitae praesent ultrices libero tincidunt magna.\n\nImperdiet vitae praesent ultrices libero tincidunt magna.\nImperdiet vitae praesent ultrices libero tincidunt magna."
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyTextView.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        (storyTextView.text == "") ? animateText() : ()
    }
    
    @IBAction func textTappedd(_ sender: Any) {
        storyTextView.text = story
        timer?.invalidate()
    }
    
    
    func animateText(){
        var charIndex = 0.0
        for letter in story {
            let time = 0.1 * charIndex
            timer = Timer.scheduledTimer(withTimeInterval: time, repeats: false) { (_) in
                self.storyTextView.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
}
