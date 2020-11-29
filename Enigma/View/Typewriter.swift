//
//  Typewriter.swift
//  Enigma
//
//  Created by Aaryan Kothari on 28/11/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

open class TypingLetterUITextView: UITextView {
    
    open var typingTask:DispatchWorkItem?
    open var isTyping:Bool = false
    
    open func updateTypingTextView(_ character:Character){
        self.text = self.text! + String(character)
        self.scrollTextViewToBottom(textView: self)
    }
    
    open func cleanupAfterFinishedTyping(){
        self.typingTask = nil
        isTyping = false
    }
    
    func scrollTextViewToBottom(textView: UITextView) {
        if textView.text.count > 0 {
            let location = textView.text.count - 1
            let bottom = NSMakeRange(location, 1)
            textView.scrollRangeToVisible(bottom)

            // an iOS bug, see https://stackoverflow.com/a/20989956/971070
            textView.isScrollEnabled = false
            textView.isScrollEnabled = true
        }
    }

    
    open func typeText(_ content: String, delimiter:String? = nil, typingSpeedPerChar: TimeInterval = 0.04, didResetContent:Bool = true, completeCallback:(()->Void)?) {
        
        let content = delimiter ?? ""

        if isTyping {
            self.typingTask?.cancel()
            self.typingTask = nil
            isTyping = false
        }
        
        if (didResetContent){
            self.text = ""
        }
        
        if content.count == 0{
            completeCallback?()
        }
        
        self.typingTask = DispatchWorkItem { [weak self] in
            self?.isTyping = true
            for character in content {
                if self?.isTyping == false{
                    break
                }
                DispatchQueue.main.async {
                    self?.updateTypingTextView(character)
                }
                Thread.sleep(forTimeInterval: typingSpeedPerChar)
            }
            completeCallback?()
            self?.cleanupAfterFinishedTyping()
        }
        if let task = self.typingTask {
            let queue = DispatchQueue(label: "rimhTypingLetter", qos: DispatchQoS.userInteractive)
            queue.asyncAfter(deadline: .now() + 0.1, execute: task)
        }
    }
}
