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
    
    @IBOutlet weak var headerView: UIView!
    
    let leaderboardIdentifer = "leadercell"
    
    let leaderboard = [Leaderboard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}

extension LeaderboardViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: leaderboardIdentifer) as! LeaderboardCell
        
        let data = leaderboard[indexPath.row]
        
        cell.rank.text = (indexPath.row+1).stringValue
        cell.userName.text = data.username
        cell.solved.text = data.solved?.stringValue
        cell.score.text = data.score?.stringValue

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}
