//
//  HintAlert.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation
import UIKit

class HintAlert: UIView {

    override init(frame : CGRect){
        super.init(frame : frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var hintTitle: UILabel!
    @IBOutlet weak var hintSubtitle: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!

    
}
