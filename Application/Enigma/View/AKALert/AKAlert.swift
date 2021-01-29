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
        self.AKAlertWillDisappear()
    }
    
    enum ALertType{
        case success
        case failure
        case close
        case custom(message: String)
        
        var message : String{
            switch self {
            case .success:
                return "Correct Response"
            case .failure:
                return "Try again !"
            case .close:
                return "Response is close to the answer"
            case .custom(let message):
                return message
            }
        }
        
        var title : String{
         switch self {
            case .success:
                return "success"
            case .failure:
                return "failure"
            case .close:
                return "close"
         case .custom(_):
            return "close"
            }
        }
        
        var icon : UIImage?{
            return UIImage(named: self.title)
        }
    }
    
    private func initSubViews() {
        let nib = UINib (nibName: String (describing: type(of: self) ), bundle: Bundle ( for: type(of: self) ))
        nib.instantiate (withOwner: self, options: nil)
        AKAlertView.translatesAutoresizingMaskIntoConstraints = false
        addSubview (AKAlertView)
        AKAlertView.addBorder(width: 4, .primary, alpha: 0.8)
        self.addConstraints()
        self.AKAlertWillAppear()
        self.addTapToDismiss()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: AKAlertView.topAnchor),
            self.leadingAnchor.constraint(equalTo: AKAlertView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: AKAlertView.trailingAnchor),
            self.bottomAnchor.constraint(equalTo : AKAlertView.bottomAnchor)])
    }
    
    private func addTapToDismiss(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapOnAKAlert(sender:)))
        AKAlertView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapOnAKAlert(sender : UITapGestureRecognizer){
        self.AKAlertWillDisappear(after: 0.0)
    }
    
    private func AKAlertWillAppear(){
        AKAlertView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        UIView.animate(withDuration: 0.2){
            self.AKAlertView.transform = .identity
        }
    }
    
    private func AKAlertWillDisappear(after seconds : Double = 3.0){
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: {
            UIView.animate(withDuration: 0.5, animations: {
                self.AKAlertView.alpha = 0.0
                self.AKAlertView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }) { _ in
                self.AKAlertView.removeFromSuperview()
                self.removeFromSuperview()
            }
        })
    }
    
}
