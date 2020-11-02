//
//  LaunchScreen.swift
//  Enigma
//
//  Created by Aaryan Kothari on 02/11/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import AVFoundation

class LaunchScreen: UIViewController {
    

    @IBOutlet weak var subLabel: UILabel!
    
    var string = "online cryptic hunt"
    var substring = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LOAD")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for i in string {
            AudioServicesPlaySystemSound(1306)
            substring += "\(i)"
            subLabel.text! = "< " + substring + " >"
            RunLoop.current.run(until: Date()+0.20)
        }
        performSegue(withIdentifier: "start", sender: nil)
    }
}
