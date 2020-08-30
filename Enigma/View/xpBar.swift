//
//  xpBar.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation
import UIKit


final class xpBar: CAShapeLayer, CAAnimationDelegate {
    
    var start : CGFloat = 0.33
    var end : CGFloat = 0.66
    
    var animationDuration: TimeInterval = 0
    
    var progress = CAShapeLayer()
    var gradient = CAGradientLayer()
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(for view: UIView, duration: TimeInterval, startValue start : CGFloat, endValue end : CGFloat ) {
        super.init()
        self.animationDuration = duration
        self.start = start
        self.end = end
        
        DispatchQueue.main.async {
            self.showProgress(view: view)
        }
    }
    
    func showProgress(view: UIView) {
        let width  : CGFloat = view.frame.width
        let height  : CGFloat = view.frame.height
        let heightFactor = height/2

        let barPath = UIBezierPath()
        barPath.move(to: CGPoint(x: heightFactor, y: heightFactor))
        barPath.addLine(to: CGPoint(x:(end * width)-(heightFactor), y: heightFactor))
        
        progress.path = barPath.cgPath
        progress.fillColor = UIColor.clear.cgColor
        progress.lineWidth = height
        progress.strokeEnd =  start > 0.5 ? (1-start) : (start)
        progress.lineCap = .square
        progress.strokeColor = UIColor.red.cgColor
        
        gradient.colors = [ UIColor.secondary.cgColor, UIColor.quaternary.cgColor ]
        gradient.frame = view.bounds
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75 * end, y: 0.5)
        gradient.mask = progress
        
        self.insertSublayer(gradient, above: self)
        
        let strokeEnd = animate(duration: animationDuration)
        self.progress.add(strokeEnd, forKey: "strokeEnd")
    }
    
    func animate(duration: TimeInterval) -> CABasicAnimation {
        let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        strokeEnd.duration = duration
        strokeEnd.toValue = 1.0
        strokeEnd.isRemovedOnCompletion = false
        strokeEnd.fillMode = .forwards
        return strokeEnd
    }
}


