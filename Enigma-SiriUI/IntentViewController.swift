//
//  IntentViewController.swift
//  Enigma-SiriUI
//
//  Created by Aaryan Kothari on 25/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import IntentsUI

class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    @IBOutlet weak var tableView: UITableView!
    
    let leaderCellId = "leadercell"
    
    var leaderboard = [Leader]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        guard interaction.intent is LeaderboardIntent else {
            let vc = ProfileIntentViewController()
            self.addChild(vc)
          completion(false, Set(), .zero)
          return
        }
        
        if let response = interaction.intentResponse as? LeaderboardIntentResponse {
            guard let leaderboard = response.leaderboard else { return } //TODO
            self.leaderboard = leaderboard.filter{ $0.username != "" }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        completion(true, parameters, self.desiredSize)
    }
    
    var desiredSize: CGSize {
        var size = self.extensionContext!.hostedViewMaximumAllowedSize
        size.height /= 2
        return size
    }
    
}

extension IntentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: leaderCellId) as! LeaderboardCell
        let data = leaderboard[indexPath.row]
        cell.rank.text = (indexPath.row+1).stringValue
        cell.userName.text = data.username
        cell.solved.text = data.solved?.stringValue
        cell.score.text = data.score?.stringValue
        return cell
    }
}
