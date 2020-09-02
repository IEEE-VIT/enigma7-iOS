//
//  ViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 01/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

extension UIViewController {
    func present(_ identifier : String){
        let viewController  = storyBoard.instantiateViewController(identifier: identifier)
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
