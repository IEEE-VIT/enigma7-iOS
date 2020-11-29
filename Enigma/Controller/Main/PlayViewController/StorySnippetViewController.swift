//
//  StorySnippetViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 21/11/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class StorySnippetViewController: UIViewController {
    
    @IBOutlet weak var story: UITextView!
    @IBOutlet weak var gifView: UIView!
    
    var timer: Timer?
    var playerLooper: AVPlayerLooper!
    
    var text: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.story.text = text
        //animateText()
        playVideo()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.text = ""
        self.timer?.invalidate()
        self.timer = nil
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    func animateText(){
        story.text = ""
        var charIndex = 0.0
        for letter in text {
            let time = 0.1 * charIndex
            timer = Timer.scheduledTimer(withTimeInterval: time, repeats: false) { (_) in
                if self.timer != nil {
                    self.story.text?.append(letter)
                    if self.extimateFrameForText() > self.story.frame.height {
                        let point = CGPoint(x: 0.0, y: (self.story.contentSize.height - self.story.bounds.height))
                        self.story.setContentOffset(point, animated: true)
                    }
                }
            }
            charIndex += 1
        }
    }
    
    private func extimateFrameForText() -> CGFloat {
        let size = CGSize(width: self.story.frame.width, height: 1000)
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font : UIFont.init(name: "IBMPlexMono", size: 16)!]
        let string = NSString(string: self.story.text)
        let height = string.boundingRect(with: size, options: options, attributes: attributes, context: nil).height
        
        return height
    }
    
    
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "enigma", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.gifView.bounds
        self.gifView.layer.addSublayer(playerLayer)
        player.play()
    }
    
}

extension UITextView {
    func simple_scrollToBottom() {
        let textCount: Int = text.count
        guard textCount >= 1 else { return }
        scrollRangeToVisible(NSRange(location: textCount - 1, length: 1))
        self.isScrollEnabled = false
        self.isScrollEnabled = true
    }
}

extension UITextView {
    func typeOn(string: String) {
        let characterArray = string.characterArray
        var characterIndex = 0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            if characterArray[characterIndex] != "$" {
                while characterArray[characterIndex] == " " {
                    self.text.append(" ")
                    characterIndex += 1
                    if characterIndex == characterArray.count {
                        timer.invalidate()
                        return
                    }
                }
                self.text.append(characterArray[characterIndex])
                self.simple_scrollToBottom()
            }
            characterIndex += 1
            if characterIndex == characterArray.count {
                timer.invalidate()
            }
        }
    }
}

extension String {
    var characterArray: [Character]{
        var characterArray = [Character]()
        for character in self{
            characterArray.append(character)
        }
        return characterArray
    }
}
