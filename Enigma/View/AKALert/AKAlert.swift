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
    
    init(type : ALertType) {
        super.init(frame: CGRect())
        self.initSubViews()
        self.alertMessage.text = type.message
        self.alertIcon.image = type.icon
        self.dismissAlert()
    }
    
    func dismissAlert(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            UIView.animate(withDuration: 0.5, animations: {
                self.AKAlertView.alpha = 0.0
                self.AKAlertView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }) { _ in
                self.AKAlertView.removeFromSuperview()
                self.removeFromSuperview()
            }
        })
    }
    
    enum ALertType : String{
        case success
        case failure
        case close
        
        var message : String{
            switch self {
            case .success:
                return "Correct Response"
            case .failure:
                return "Try again !"
            case .close:
                return "Response is close to the answer"
            }
        }
        
        var icon : UIImage?{
            return UIImage(named: self.rawValue)
        }
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
    
    private func AKAlertdidAppear(){
        AKAlertView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        UIView.animate(withDuration: 0.2){
            self.AKAlertView.transform = .identity
        }
    }
    
}
