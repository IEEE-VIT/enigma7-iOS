//
//  RulesViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class RulesViewController: UIViewController {

    @IBOutlet weak var rulesTextView: UITextView!
    
    let rules = "Etiam fermentum ut bibendum egestas id maecenas aliquam lacinia nulla.\n\nTempor enim viverra eu laoreet.\n\nOrnare iaculis sed adipiscing fringilla tincidunt arcu eget morbi at odio nisi ipsum sit congue vivamus ut euismod euismod nec augue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rulesTextView.text = rules
    }

}
