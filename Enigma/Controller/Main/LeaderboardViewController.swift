//
//  LeaderboardViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let leaderboardIdentifer = "leadercell"
    
    let leaderboard = [LeaderboardModel(userName: "RavenClaw", solved: 6, score: 42),LeaderboardModel(userName: "Hufflepuff", solved: 4, score: 40),LeaderboardModel(userName: "Gryffindor", solved: 3, score: 35),LeaderboardModel(userName: "Slitherine", solved: 3, score: 30),LeaderboardModel(userName: "yolo123", solved: 2, score: 26),LeaderboardModel(userName: "bruh", solved: 1, score: 25),LeaderboardModel(userName: "anonymous", solved: 0, score: 0)]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension LeaderboardViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: leaderboardIdentifer) as! LeaderboardCell
        
        let data = leaderboard[indexPath.row]
        
        cell.rank.text = data.rank.stringValue
        cell.userName.text = data.userName
        cell.solved.text = data.solved.stringValue
        cell.score.text = data.score.stringValue

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
}
