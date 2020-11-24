//
//  LeaderboardViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import Intents

class LeaderboardViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var leaderboard = [Leaderboard]()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleLeaderBoard(leaderboard: Defaults.leaderboard())
        setupRefreshControl()
        donateIntent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ServiceController.shared.getLeaderboard(completion: handleLeaderBoard(leaderboard:))
    }
    
    func handleLeaderBoard(leaderboard: [Leaderboard]?){
        guard let leaderboard = leaderboard else { return }
        self.leaderboard = leaderboard
        INInteraction(intent: LeaderboardIntent(), response: nil).donate(completion: nil)
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    func setupRefreshControl(){
        tableView.refreshControl = refreshControl
        refreshControl.tintColor = .tertiary
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    }
    
    @objc func refresh(_ sender: Any) {
       ServiceController.shared.getLeaderboard(completion: handleLeaderBoard(leaderboard:))
    }
    

}

extension LeaderboardViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.CellId.leaderboardCell) as! LeaderboardCell
        
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
    
    private func donateIntent() {
           let intent = LeaderboardIntent()
           intent.suggestedInvocationPhrase = "Enigma leaderboard"
           let interaction = INInteraction(intent: intent, response: nil)
           interaction.donate(completion: { (error) in
               if let error = error {
                    print(error.localizedDescription)
               }
           })
    }
    
}
