//
//  PlayViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet var powerupButtons: [UIButton]!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var answerTextField: CustomTextField!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var subScrollView: UIView!
    var previousTag : Int = 0
    
    let hint = "Vitae habitasse fames feugiat morbi."
    
    var startingImageFrame : CGRect?
    var backgroundView : ImageScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for button in powerupButtons{
            setButton(button,false)
        }
        submitButton.addBorder(width: 2, .tertiary)
        questionImageView.addBorder(width: 2, .tertiary)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showProgress()
        subscribeToKeyboardNotifications()
        progressBar.layer.borderWidth = 1.5
        progressBar.layer.borderColor = UIColor.secondary.cgColor
        questionImageView.image = UIImage(named: "sample")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    @IBAction func submitTapped(_ sender: Any) {
        let alert = AKAlert(type: .success)
        let width = UIScreen.main.bounds.width * 0.8
        let height = width / 3.33
        alert.frame = CGRect(x: 0, y: 0, width: width, height: height)
        self.view.addSubview(alert)
        alert.center = self.view.center
    }
    
    
    @IBAction func powerupTapped(_ sender: UIButton) {
        let powerup = sender.tag
        let powerupButton = powerupButtons[powerup]
        
        setButton(powerupButtons[previousTag],false)
        setButton(powerupButton, true)
        
        self.previousTag = sender.tag
    }
    
    
    @IBAction func hintTapped(_ sender: Any) {
        let headerView = HintAlert()
        headerView.modalPresentationStyle = .overFullScreen
        headerView.delegate = self
        self.present(headerView, animated: false, completion: nil)
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
            self.performZoom()
       }
    
    private func getCoordinate(_ view: UIView) -> CGPoint {
        var x = view.frame.origin.x
        var y = view.frame.origin.y
        var oldView = view

        while let superView = oldView.superview {
            x += superView.frame.origin.x
            y += superView.frame.origin.y
            if superView.next is UIViewController {
                break //superView is the rootView of a UIViewController
            }
            oldView = superView
        }

        return CGPoint(x: x, y: y)
    }
       
       func performZoom(){
           startingImageFrame = questionImageView.superview?.convert(questionImageView.frame, to: nil)
           startingImageFrame?.origin = getCoordinate(questionImageView)
           let zoomingImageView = UIImageView(frame: self.startingImageFrame ?? CGRect())
           zoomingImageView.image = questionImageView.image
           zoomingImageView.isUserInteractionEnabled = true
           zoomingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomout)))
           
           var aspectRatio : CGFloat = 1
           
        backgroundView = ImageScrollView(frame: view.frame)
         backgroundView.setup()
    

           backgroundView?.backgroundColor = .dark
           backgroundView?.alpha = 0
          view.addSubview(backgroundView!)
           view.addSubview(zoomingImageView)
           if let image = questionImageView.image {
               aspectRatio = image.size.width / image.size.height
           }
           let width = view.frame.width
           let center = view.center
           let height = width / aspectRatio
           UIView.animate(withDuration: 0.5, delay: 0,usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            zoomingImageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            zoomingImageView.center = center
            self.backgroundView?.alpha = 1
           }){ (completed : Bool) in
               self.questionImageView.isHidden = true
               zoomingImageView.isHidden = true
            if let image = self.questionImageView.image {
                self.backgroundView.display(image: image)
            }
           }
       }
       
        //MARK:- Image / Video Zoomout on tap
       @objc func zoomout(tapGesture: UITapGestureRecognizer){
           print("zoom  out")
           if  let zoomOutImageView = tapGesture.view{
               UIView.animate(withDuration: 0.5, delay: 0,usingSpringWithDamping: 1, initialSpringVelocity: 1 ,options: .curveEaseOut, animations: {
                   zoomOutImageView.frame = self.startingImageFrame!
                   self.backgroundView?.alpha = 0
               }) { (completed : Bool) in
                   zoomOutImageView.removeFromSuperview()
                   self.backgroundView?.removeFromSuperview()
                   self.questionImageView?.isHidden = false
               }
           }
       }
    
    func showProgress(){
        let progress = xpBar(for: progressBar, duration: 1.5, startValue: 0.0, endValue: 0.6)
        self.progressBar.layer.insertSublayer(progress, above: self.progressBar.layer)
    }
    
    func setButton(_ button : UIButton ,_ bool : Bool){
        if !bool {
            button.addBorder(width: 1, .quaternary, alpha: 0.2)
            button.backgroundColor = .clear
        } else{
            button.addBorder(.quaternary)
            button.backgroundColor = UIColor.primary.withAlphaComponent(0.6)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension PlayViewController : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 1) {
            let scrollPoint = CGPoint(x: 0, y: 80)
            self.scroll.setContentOffset(scrollPoint, animated: true)
        }
    }
}

extension PlayViewController : AlertDelegate{
    func hintUsed() {
        hintLabel.isUserInteractionEnabled = false
        hintLabel.text = self.hint
        hintLabel.textAlignment = .left
    }
}


//MARK:- Keyboard show + hide functions
extension PlayViewController {
    //MARK: Add Observers
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    //MARK: Remove Observers
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    //MARK: Move stackView based on keybaord
    @objc func keyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        //MARK: Get Keboard Y point on screen
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameY = endFrame?.origin.y ?? 0
        
        //MARK: Get keyboard display time
        let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        
        //MARK: Set animations
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        // MARK: Get Keyboard Top Inset
        let viewHeight = UIScreen.main.bounds.height
        let keyboardIsUp = endFrameY == viewHeight
        let textFieldY = self.answerTextField.frame.origin.y + 39 + (viewHeight * 0.09)
        let offset = endFrameY  - textFieldY
        let scrollPoint = CGPoint(x: 0, y: keyboardIsUp ? .zero : offset)
        self.scroll.setContentOffset(scrollPoint, animated: true)
        
        
        UIView.animate(withDuration: duration,
                       delay: TimeInterval(0),
                       options: animationCurve,
                       animations: { self.view.layoutIfNeeded() },
                       completion: nil)
    }
}
