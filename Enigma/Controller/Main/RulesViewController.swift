//
//  RulesViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class RulesViewController: UIViewController {
    
    @IBOutlet weak var RulesTableView: UITableView!
    
    @IBOutlet weak var bottomAnchor: NSLayoutConstraint!
    @IBOutlet weak var bottomLabel: UILabel!
    
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
    
    var hideLabel: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomAnchor.constant = hideLabel ? -10 : 31
        bottomLabel.isHidden = hideLabel
        if #available(iOS 13.0, *) { overrideUserInterfaceStyle = .light }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.RulesTableView.reloadData()
    }

}

extension RulesViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellToReturn = UITableViewCell()
        if indexPath.row == 7{
            let cell = RulesTableView.dequeueReusableCell(withIdentifier: AppConstants.CellId.xpCell)
            cellToReturn = cell!
        } else {
        let cell = RulesTableView.dequeueReusableCell(withIdentifier: AppConstants.CellId.rulesCell) as! RulesCell
        cell.rule.text = rule(at: indexPath.row)
        cellToReturn = cell
        }
        return cellToReturn
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return extimateFrameForText(at: indexPath.row)
    }
    
    private func rule(at index:Int) -> String{
        return rules[index]
    }
    
    private func extimateFrameForText(at index: Int) -> CGFloat {
        let text = rule(at: index)
        let screenWidth = view.frame.width
        let imageHeight = (index == 7) ? (screenWidth-40) * 0.20 : 0.0
        let width = view.frame.width - 60
        print(width,screenWidth)
        let size = CGSize(width: width, height: 1000)
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font : UIFont.init(name: "IBMPlexMono", size: 16)!]
        let string = NSString(string: text)
        let height = string.boundingRect(with: size, options: options, attributes: attributes, context: nil).height
        
        return height + 20 + imageHeight
    }
    
}

