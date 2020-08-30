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
    
    ///`Function To add Border to Button`
    /// color - the borderColor of the button
    /// width - the borderWidth of the button ( Default = 1 px )
    func addBorder(width : CGFloat = 1,_ color : UIColor, alpha : CGFloat = 1){
        self.layer.borderWidth = width
        let borderColor = color.withAlphaComponent(alpha).cgColor
        self.layer.borderColor = borderColor
    }
    
}
