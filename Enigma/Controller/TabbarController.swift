//
//  TabbarController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class TabbarController: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var containerView: UIView!
    
    var HomeViewController: UIViewController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
           HomeViewController = storyboard.instantiateViewController(identifier: "HomeViewController")
        setupView(HomeViewController)
        containerFrame = containerView.frame
    }
    
    
    @IBAction func tabSelected(_ sender: UIButton) {
        
    }
    
    func setupView(_ viewController : UIViewController){
        viewController.view.frame = containerView.bounds
        viewController.view.layer.cornerRadius = 4
        viewController.view.layer.borderWidth = 3
        viewController.view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        containerView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }


}

var containerFrame = CGRect()
