//
//  Storyboard.swift
//  Enigma
//
//  Created by Aaryan Kothari on 08/12/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

//MARK: Extension for UIStoryboard

extension UIStoryboard {
    // Instantiate ViewController
    // iOS 12+
    func instantiateViewController(_ id : String)->UIViewController{
        if #available(iOS 13.0, *) {
            return  self.instantiateViewController(identifier: id)
        } else {
            return self.instantiateViewController(withIdentifier: id)
        }
    }
}
