//
//  CustomTextField.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    override func caretRect(for position: UITextPosition) -> CGRect {
        var rect = super.caretRect(for: position)
        let size = CGSize(width: 8, height: 21)
        let y = rect.origin.y - (size.height - rect.size.height)/2
        rect = CGRect(origin: CGPoint(x: rect.origin.x, y: y), size: size)
        return rect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
}

extension UITextField{
    func setUI(){
        self.backgroundColor = #colorLiteral(red: 0.05169083923, green: 0.09415727109, blue: 0.06114685535, alpha: 1)
        self.layer.borderColor = UIColor(named: "black")?.cgColor
    }
}
