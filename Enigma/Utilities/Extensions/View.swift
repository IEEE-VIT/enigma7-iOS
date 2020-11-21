//
//  View.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

extension UIView {
    
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
    
   func roundCorners(corners: UIRectCorner, radius: CGFloat = 4) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addBorder(width : CGFloat = 1,_ color : UIColor, alpha : CGFloat = 1){
        self.layer.borderWidth = UIDevice.current.ipadOutlineMultiplier(width)
        let borderColor = color.withAlphaComponent(alpha).cgColor
        self.layer.borderColor = borderColor
    }
}

public extension UIView
{
    static func loadFromXib<T>(withOwner: Any? = nil, options: [UINib.OptionsKey : Any]? = nil) -> T where T: UIView
    {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "\(self)", bundle: bundle)

        guard let view = nib.instantiate(withOwner: withOwner, options: options).first as? T else {
            fatalError("Could not load view from nib file.") //TODO add constant
        }
        return view
    }
}
