//
//  RulesController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 27/11/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import WatchKit

class RulesController: WKInterfaceController {

    
    @IBOutlet weak var table: WKInterfaceTable!
    
    let rules = [
        "ENIGMA 7.0 is an online cryptic hunt where players solve a series of challenging riddles and puzzles to win exciting prizes.",
        "The points earned on answering each question are completely relative to the competition - the earlier you solve a question, the higher your score will be. These points determine your position on the leaderboard.",
        "Upon using a hint, a one-time penalty of 15% shall be applied on the points earned from the corresponding question.",
        "Every player will have xp (experience points) which can be redeemed to use power ups.",
        "xp does not play a part in determining the leaderboard position and is different from “points” mentioned.",
        "All players start with 0 xp and can collect a maximum of 100 xp.",
        "Players earn xp every hour and upon solving the questions.",
        "There are three different power ups that players can redeem from the collected xp.",
        "The first power up, Free hint (consumes 50 xp), gives the player the hint to the question without the penalty to their points.",
        "The second power up, Close answer (consumes 80 xp), the players can successfully move to the next question and earn points for the question.",
        "The third power up, Skip question (consumes 100 xp), the players can skip the current question but will not be awarded any points.",
        "Any form of malpractice shall be dealt with extreme seriousness. We are constantly trying to enhance the experience and security of the system. Your cooperation is highly appreciated."]
        
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        loadTable()
        
    }
    
    func loadTable(){
        table.setNumberOfRows(rules.count, withRowType: "rulesrow")
        for i in 0..<self.table.numberOfRows {
            guard let controller = self.table.rowController(at: i) as? RulesRow else { continue }
            controller.text = rules[i]
        }
    }
}

