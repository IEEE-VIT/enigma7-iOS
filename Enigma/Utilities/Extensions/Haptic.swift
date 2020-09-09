//
//  Haptic.swift
//  Enigma
//
//  Created by Aaryan Kothari on 09/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class Haptic{
    static func hapticFeedback(_ style : HapticStyle){
        
        switch style {
        case .haptic(let haptic):
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(haptic)
        case .impact(let impact):
            let generator = UIImpactFeedbackGenerator(style: impact)
            generator.prepare()
            generator.impactOccurred()
        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
    
     enum HapticStyle{
        case haptic(UINotificationFeedbackGenerator.FeedbackType)
        case impact(UIImpactFeedbackGenerator.FeedbackStyle)
        case selection
    }
}
