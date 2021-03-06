//
//  LeaderboardRow.swift
//  EnigmaWatch Extension
//
//  Created by Aaryan Kothari on 21/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import WatchKit

class LeaderboardRow: NSObject {

    @IBOutlet weak var rankLabel: WKInterfaceLabel!
    @IBOutlet weak var userNameLabel: WKInterfaceLabel!
    
    var rank : String = "0. "
    
    var leaderboard : Leaderboard?{
        didSet{
            guard let leaderboard = leaderboard else { return }
            rankLabel.setText(rank)
            userNameLabel.setText(leaderboard.username)
        }
    }
}
