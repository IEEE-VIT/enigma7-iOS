//
//  Button.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

//MARK: Extension for UIBUTTON

extension UIButton {
    func bottomShadow(_ value : CGFloat){
        if self.tag != 4{
            self.layer.shadowColor = #colorLiteral(red: 0.07450980392, green: 0.07843137255, blue: 0.07450980392, alpha: 1).cgColor
            self.layer.shadowOffset = CGSize(width: 0.0, height: value)
            self.layer.shadowOpacity = 1.0
            self.layer.shadowRadius = 0
            self.layer.masksToBounds = false
        }
    }
}
