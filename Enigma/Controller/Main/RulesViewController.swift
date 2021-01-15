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
    
    let rules = AppConstants.Rules.rules
    
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
        let size = CGSize(width: width, height: 1000)
        
        let fontsize : CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 32 : 16
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font : UIFont.init(name: "IBMPlexMono", size: fontsize)!]
        let string = NSString(string: text)
        let height = string.boundingRect(with: size, options: options, attributes: attributes, context: nil).height
        
        return height + 20 + imageHeight
    }
    
}

