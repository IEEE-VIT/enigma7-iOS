//
//  ViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 01/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

//MARK: Extension for UIViewController

extension UIViewController {
    /// present viewcontroller in custom `Tabbar`
    func present(_ identifier : String){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController  = storyBoard.instantiateViewController(identifier)
        viewController.view.frame = self.view.bounds
        viewController.view.layer.cornerRadius = 4
        viewController.view.layer.borderWidth = 3
        viewController.view.layer.borderColor = UIColor.black.cgColor
        viewController.willMove(toParent: self)
        self.view.addSubview(viewController.view)
        self.addChild(viewController)
        
        viewController.didMove(toParent: self)
    }
}
