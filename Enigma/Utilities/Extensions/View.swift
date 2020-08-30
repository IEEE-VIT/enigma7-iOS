//
//  View.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat = 4) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addBorder(width : CGFloat = 1,_ color : UIColor, alpha : CGFloat = 1){
        self.layer.borderWidth = width
        let borderColor = color.withAlphaComponent(alpha).cgColor
        self.layer.borderColor = borderColor
    }
}
