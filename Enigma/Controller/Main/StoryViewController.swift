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
    
    var story = "Imperdiet vitae praesent ultrices libero tincidunt magna.\n\nImperdiet vitae praesent ultrices libero tincidunt magna.\n\nImperdiet vitae praesent ultrices libero tincidunt magna.\n\nImperdiet vitae praesent ultrices libero tincidunt magna.\n\nImperdiet vitae praesent ultrices libero tincidunt magna.\nImperdiet vitae praesent ultrices libero tincidunt magna."
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyTextView.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleStory(story: Defaults.fullStory()?.stories ?? [])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ServiceController.shared.getFullStory(completion: handleStory(story:))
    }
    
    func handleStory(story:[Story]){
        let texts = story.map{ $0.story?.text ?? "" }
        let storyText = texts.joined(separator: "\n\n")
        self.story = storyText
        self.storyTextView.text = storyText
    }
    
    func handleStoryWithAnimation(story:Story?){
        guard let text = story?.story?.text else { return }
        self.story = text
        animateText()
    }
    
    @IBAction func textTappedd(_ sender: Any) {
        storyTextView.text = story
        timer?.invalidate()
        timer = nil
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
