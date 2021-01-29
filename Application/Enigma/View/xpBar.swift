//
//  xpBar.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation
import UIKit

//MARK: - NicoProgressBar
open class xpBar: UIView {
    private var progressBarIndicator: UIView!
    
    private var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.secondary.cgColor, UIColor.quaternary.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = CGRect.zero
       return gradientLayer
    }()
    
    //MARK: UIView
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        DispatchQueue.main.async {
            self.moveProgressBarIndicatorToStart()
        }
    }
    
    //MARK: Setup
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.backgroundColor = .dark
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.secondary.cgColor
        progressBarIndicator = UIView(frame: zeroFrame)
        progressBarIndicator.backgroundColor = .quaternary
        progressBarIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(progressBarIndicator)
        moveProgressBarIndicatorToStart()
        progressBarIndicator.layer.addSublayer(gradientLayer)
    }
    
    
    // MARK: Private
    func animateProgress(toPercent percent: CGFloat, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: 1.5,
            delay: 0,
            options: [.beginFromCurrentState],
            animations: {
                self.progressBarIndicator.frame = CGRect(x: 0, y: 0,width: self.bounds.width * percent,height: self.bounds.size.height)
                self.gradientLayer.frame = self.progressBarIndicator.bounds
            },
            completion: completion)
    }
    
    private func moveProgressBarIndicatorToStart() {
        progressBarIndicator.layer.removeAllAnimations()
        progressBarIndicator.frame = zeroFrame
        progressBarIndicator.layoutIfNeeded()
    }
    
    private var zeroFrame: CGRect {
        return CGRect(origin: .zero, size: CGSize(width: 0, height: bounds.size.height))
    }
}
