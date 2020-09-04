//
//  AKAlert.swift
//  Enigma
//
//  Created by Aaryan Kothari on 04/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class AKAlert: UIView {
    
    @IBOutlet weak var alertIcon: UIImageView!
    @IBOutlet weak var alertMessage: UILabel!
    @IBOutlet var AKAlertView: UIView!
    
    override init(frame : CGRect) {
        super.init (frame : frame)
        self.initSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init (coder: coder)
        self.initSubViews()
        fatalError("init(coder:) has not been implemented")
    }
    
    init(s: String, i: Int) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.initSubViews()
    }
    
    private func initSubViews() {
        let nib = UINib (nibName: String (describing: type(of: self) ), bundle: Bundle ( for: type(of: self) ))
        nib.instantiate (withOwner: self, options: nil)
        AKAlertView.translatesAutoresizingMaskIntoConstraints = false
        addSubview (AKAlertView)
        AKAlertView.addBorder(width: 4, .primary, alpha: 0.8)
        self.addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: AKAlertView.topAnchor),
            self.leadingAnchor.constraint(equalTo: AKAlertView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: AKAlertView.trailingAnchor),
            self.bottomAnchor.constraint(equalTo : AKAlertView.bottomAnchor)])
    }
    
}
