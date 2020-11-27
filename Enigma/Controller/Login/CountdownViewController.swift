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
    var interval : TimeInterval = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = AppConstants.Date.dateFormat
        formatter.timeZone = TimeZone(abbreviation: "IST")
        formatter.locale = Locale(identifier: "en_US_POSIX")
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
            countdownTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { (_) in self.calculateTimeDifference() })
        }
        startButton.isHidden = !started
    }
    
    func presentAKAlert(type: AKAlert.ALertType){
        let width = UIScreen.main.bounds.width * 0.8
        let height = width / 3.33
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        let alert = AKAlert(type: type)
        alert.frame = frame
        self.view.addSubview(alert)
        alert.center = self.view.center
    }
    
    
    @IBAction func startClicked(_ sender: UIButton) {
        ServiceController.shared.getStatus { (started, date) in
            if started {
                UserDefaults.standard.set(true, forKey: Keys.started)
                self.present(AppConstants.ViewController.RulesViewController)
            } else {
                self.presentAKAlert(type: .custom(message: "Enigma will start at \(date) IST"))
            }
        }
    }
    
    
    func calculateTimeDifference(){
        let enigmaDate = formatter.date(from: startDate)
        print("date value:",enigmaDate,"startdate:",startDate,"format:",formatter.dateFormat)
        if Date() > enigmaDate ?? Date(timeIntervalSince1970: 1607079000){
            self.dayLabel.text = "00"
            self.hourLabel.text = "00"
            self.minutLabel.text = "00"
            self.secondLabel.text = "00"
            self.startButton.isHidden = false
        } else {
            /// Calculate time difference
            let calender = Calendar.current
            let currentDate = Date()
            let startdate = formatter.date(from: startDate) ?? Date(timeIntervalSince1970: 1607079000)
            let dateComponents = calender.dateComponents([.day,.hour,.minute,.second], from: currentDate, to: startdate)
            
            
            /// Set labels
            self.dayLabel.text = (dateComponents.day ?? 0).timeValue
            self.hourLabel.text = (dateComponents.hour ?? 0).timeValue
            self.minutLabel.text = (dateComponents.minute ?? 0).timeValue
            self.secondLabel.text = (dateComponents.second ?? 0).timeValue
        }
    }
    
    

}
