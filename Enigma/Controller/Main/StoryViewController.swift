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
    
    var story = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        storyTextView.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        storyTextView.text = ""
        ServiceController.shared.getFullStory(completion: handleStory(story:))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func handleStory(story:[Story]){
        let texts = story.map{ $0.story?.text ?? "" }
        let storyText = formatStory(texts)
        self.story = storyText
        self.storyTextView.text = storyText
        let bottom = NSMakeRange(storyTextView.text.count - 1, 1)
        self.storyTextView.scrollRangeToVisible(bottom)
    }
    
    func formatStory(_ story: [String]) -> String {
        var texts = story.joined(separator: "\n\n")
        texts = texts.replacingOccurrences(of: AppConstants.Story.username, with: Defaults.username())
        texts = texts.replacingOccurrences(of: AppConstants.Story.lineBreak, with: "\n")
        return texts
    }
    
}
