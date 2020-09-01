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
    override func viewDidLoad() {
        super.viewDidLoad()
        storyTextView.text = story
    }
    
}
