//
//  HintAlert.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation
import UIKit

protocol AlertDelegate : class {
    func hintUsed()
}

class HintAlert: UIViewController {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "HintAlert", bundle: nil)
    }
    
    override func viewDidLayoutSubviews() {
        alertView.addBorder(width: 4, .primary, alpha: 0.8)
        noButton.addBorder(width: 2, .white)
        yesButton.addBorder(width: 2, .white)
    }
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var hintTitle: UILabel!
    @IBOutlet weak var hintSubtitle: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    weak var delegate : AlertDelegate?
    
    @IBAction func yesTapped(_ sender: Any) {
        delegate?.hintUsed()
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    enum AlertType{
        case normal
        case freeHint
        case skipQuestion
        
        var title : String{
            let base = "Are you sure you want to use "
            let postFix = (self == .normal) ? "hint?" : "powerup?"
            return base + postFix
        }
        
        var subtitle : String{
            let base = "[ this will deduct "
            let postFix = (self == .normal) ? "points ]" : "xp ]"
            return base + postFix
        }
    }
    
}
