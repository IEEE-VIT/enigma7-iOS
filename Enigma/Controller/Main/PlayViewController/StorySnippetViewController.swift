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
    
    var story: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.storyTextView.text = story
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.story = ""
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
}
