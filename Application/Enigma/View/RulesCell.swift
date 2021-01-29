//
//  RulesCell.swift
//  Enigma
//
//  Created by Aaryan Kothari on 27/11/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class RulesCell: UITableViewCell {
    @IBOutlet weak var rule: UITextViewFixed!
    override func layoutSubviews() {
        super.layoutSubviews()
        print(rule.frame.width)
    }
}
