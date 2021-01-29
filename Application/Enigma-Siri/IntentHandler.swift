//
//  IntentHandler.swift
//  Enigma-Siri
//
//  Created by Aaryan Kothari on 25/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        switch intent {
        case is LeaderboardIntent:
            return LeaderboardIntentHandler()
        case is ProfileIntent:
            return ProfileIntentHandler()
        default:
            fatalError("Unhandled intent type: \(intent)")
        }
    }
}
