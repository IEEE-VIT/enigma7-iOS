//
//  LeaderboardController.swift
//  EnigmaWatch Extension
//
//  Created by Aaryan Kothari on 21/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import WatchKit

class LeaderboardController: WKInterfaceController {

    @IBOutlet weak var table: WKInterfaceTable!
    
    var leaderboard = [Leaderboard]()
        
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        ServiceController.shared.getLeaderboard(completion: handleLeaderboard(leaderboard:))
    }
    
    func handleLeaderboard(leaderboard: [Leaderboard]?){
        guard let leaderboard = leaderboard else { return }
        self.leaderboard = leaderboard
        table.setNumberOfRows(leaderboard.count, withRowType: "leaderboardrow")
        for i in 0..<self.table.numberOfRows {
            guard let controller = self.table.rowController(at: i) as? LeaderboardRow else { continue }
            controller.rank = "\(i+1). "
            controller.leaderboard = leaderboard[i]
        }
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
      let user = leaderboard[rowIndex]
        let okay = WKAlertAction(title: "Aight", style: .default) { }
        presentAlert(withTitle: user.username, message: message(leader: user), preferredStyle: .alert, actions: [okay])
    }
    
    func message(leader: Leaderboard)->String{
        let name = leader.username ?? "This user"
        let score = (leader.score ?? 0).stringValue
        let ques = (leader.solved ?? 0).stringValue
        return "\(name) has a total of \(score) points after solving \(ques) questions!"
    }
    
}

