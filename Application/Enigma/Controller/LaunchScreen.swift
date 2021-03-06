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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performAnimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UserDefaults.standard.set(false, forKey: "sound")
    }
    
    func performAnimation(){
        for i in string {
            if Defaults.appOpenCount() > 3 {
            AudioServicesPlaySystemSound(1306)
            }
            substring += "\(i)"
            subLabel.text! = "< " + substring + " >"
            RunLoop.current.run(until: Date()+0.20)
        }
        if substring == string {
            performSegue(withIdentifier: "start", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tabbar = segue.destination as? TabbarController { tabbar.animateHomeVC = false }
    }
    
}
