//
//  RulesController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 27/11/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import WatchKit

class RulesController: WKInterfaceController {

    
    @IBOutlet weak var table: WKInterfaceTable!
    
    let rules = AppConstants.Rules.rules
        
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        loadTable()
        
    }
    
    func loadTable(){
        table.setNumberOfRows(rules.count, withRowType: "rulesrow")
        for i in 0..<self.table.numberOfRows {
            guard let controller = self.table.rowController(at: i) as? RulesRow else { continue }
            controller.text = rules[i]
        }
    }
}

