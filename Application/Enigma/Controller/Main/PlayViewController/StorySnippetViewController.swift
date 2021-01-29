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
