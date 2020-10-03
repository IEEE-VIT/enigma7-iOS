//
//  ProfileCell.swift
//  Enigma
//
//  Created by Aaryan Kothari on 03/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var key: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var value2: UILabel!
    
    var keyValuePair : (String,String) = ("","")
    
    var hiddenLabel : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        key.text = keyValuePair.0
        value.text = keyValuePair.1
        value2.text = keyValuePair.1
        value2.isHidden = hiddenLabel
    }
}
