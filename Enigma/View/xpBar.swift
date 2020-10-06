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
    //MARK: Private Properties
    private var progressBarIndicator: UIView!
    
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
        
        progressBarIndicator = UIView(frame: zeroFrame)
        setGradientBackground()
        progressBarIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(progressBarIndicator)
        
        moveProgressBarIndicatorToStart()
    }
    
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ UIColor.secondary.cgColor, UIColor.quaternary.cgColor ]
        gradientLayer.frame = self.bounds
        gradientLayer.locations = [0.0, 1.0]
        self.progressBarIndicator.layer.insertSublayer(gradientLayer, at:0)
    }

    
    // MARK: Private
     func animateProgress(toPercent percent: CGFloat, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: 1.5,
            delay: 0,
            options: [.beginFromCurrentState],
            animations: {
                self.progressBarIndicator.frame = CGRect(x: 0, y: 0,
                                                         width: self.bounds.width * percent,
                                                         height: self.bounds.size.height)
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
