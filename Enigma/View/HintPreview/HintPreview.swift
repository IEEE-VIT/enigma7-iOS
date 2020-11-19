//
//  HintPreview.swift
//  Enigma
//
//  Created by Aaryan Kothari on 19/11/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class HintPreview: UIViewController {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "HintPreview", bundle: nil)
    }
    
    override func viewDidLayoutSubviews() {
        hintSubtitle.text = hint
        alertView.addBorder(width: 4, .primary, alpha: 0.8)
        cancelButton.addBorder(width: 2, .white)
    }
    
    
    @IBOutlet weak var hintSubtitle: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var alertView: UIView!
    
    var hint : String = ""
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
    

    
