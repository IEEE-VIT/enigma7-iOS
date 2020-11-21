//
//  CountdownViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

protocol CountdownDelegate: class {
    func didSignin(_ token: String)
}

//TODO handle Tiemzone

class CountdownViewController: UIViewController {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minutLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    
    var startDate = AppConstants.Date.startDate
    var started : Bool = false
    let formatter = DateFormatter()
    var countdownTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = AppConstants.Date.dateFormat
      //  formatter.timeZone = .
        ServiceController.shared.getStatus(completion: handleStatus(started:date:))
        startButton.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        startButton.addBorder(UIColor.tertiary)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        countdownTimer?.invalidate()
        countdownTimer = nil
    }
    
    func handleStatus(started:Bool,date:String){
        self.startDate = date
        calculateTimeDifference()
        if started {
            countdownTimer?.invalidate()
            countdownTimer = nil
        } else {
            countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in self.calculateTimeDifference() })
        }
        startButton.isHidden = !started
    }
    
    
    @IBAction func startClicked(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: Keys.login)
        ServiceController.shared.getStatus { (started, _) in
            if started {
                self.present(AppConstants.ViewController.RulesViewController)
            }
        }
    }
    
    func calculateTimeDifference(){
        
        if Date() > formatter.date(from: startDate)! {
            self.dayLabel.text = "00"
            self.hourLabel.text = "00"
            self.minutLabel.text = "00"
            self.secondLabel.text = "00"
            
            ServiceController.shared.getStatus { (started, _) in
                if started{
                    self.startButton.isHidden = false
                    
                }
            }
        } else {
            /// Calculate time difference
            let calender = Calendar.current
            let currentDate = Date()
            let startdate = formatter.date(from: startDate)!
            let dateComponents = calender.dateComponents([.day,.hour,.minute,.second], from: currentDate, to: startdate)
            
            
            /// Set labels
            self.dayLabel.text = (dateComponents.day ?? 0).timeValue
            self.hourLabel.text = (dateComponents.hour ?? 0).timeValue
            self.minutLabel.text = (dateComponents.minute ?? 0).timeValue
            self.secondLabel.text = (dateComponents.second ?? 0).timeValue
        }
    }
    
    

}
