//
//  Device.swift
//  Enigma
//
//  Created by Aaryan Kothari on 18/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

//MARK: Extension for UIDevice

extension UIDevice{
    // change border widths for ipad
    func ipadOutlineMultiplier(_ value: CGFloat)->CGFloat{
        if self.userInterfaceIdiom == .pad{
        var double = Double(value)
            double *= 1.5
        return CGFloat(double)
        } else {
            return value
        }
    }
}
