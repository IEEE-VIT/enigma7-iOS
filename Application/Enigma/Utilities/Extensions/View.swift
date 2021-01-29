//
//  View.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

//MARK: Extension for UIView

extension UIView {
    
    // returns frame of view w.r.t sueprview of vc
    var globalFrame : CGRect {
        var x = self.frame.origin.x
        var y = self.frame.origin.y
        var oldView = self
        
        while let superView = oldView.superview {
            x += superView.frame.origin.x
            y += superView.frame.origin.y
            if superView.next is UIViewController {
                break //superView is the rootView of a UIViewController
            }
            oldView = superView
        }
        
        return CGRect(x: x, y: y, width: self.frame.width, height: self.frame.height)
    }
    
    
    // returns frame of view w.r.t superview of UISCENE
    var superGlobalFrame : CGRect {
        var x = self.frame.origin.x
        var y = self.frame.origin.y
        var oldView = self
        
        while let superView = oldView.superview {
            x += superView.frame.origin.x
            y += superView.frame.origin.y
            if superView.next is TabbarController {
                break //superView is the rootView of a UIViewController
            }
            oldView = superView
        }
        
        return CGRect(x: x, y: y, width: self.frame.width, height: self.frame.height)
    }
    
    
    // ADD CORNER RADIUS TO UIVIEW
    /// - Parameters:
    ///     - corners: which corners to round
    ///     - radius: cornerRadius value -- DEFAULT: 4 --
   func roundCorners(corners: UIRectCorner, radius: CGFloat = 4) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    // ADD Border TO UIVIEW
    /// - Parameters:
    ///     - width: width of border
    ///     - color: color of border
    ///     - alpha: opacity of border
    func addBorder(width : CGFloat = 1,_ color : UIColor, alpha : CGFloat = 1){
        self.layer.borderWidth = UIDevice.current.ipadOutlineMultiplier(width)
        let borderColor = color.withAlphaComponent(alpha).cgColor
        self.layer.borderColor = borderColor
    }
    
}
