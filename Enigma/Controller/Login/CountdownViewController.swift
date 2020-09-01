//
//  CountdownViewController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minutLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    let startDate = "23-10-2020 16:20"
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        formatter.dateFormat =  "dd-MM-yyyy HH:mm"
        calculateTimeDifference()
        super.viewDidLoad()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in self.calculateTimeDifference() })
    }
    
    func calculateTimeDifference(){
        
        /// Calculate time difference
        let calender = Calendar.current
        let currentDate = Date()
        let startdate = formatter.date(from: startDate)!
        let dateComponents = calender.dateComponents([.day,.hour,.minute,.second], from: currentDate, to: startdate)
        
        
        /// Set labels
        dayLabel.text = (dateComponents.day ?? 0).timeValue
        hourLabel.text = (dateComponents.hour ?? 0).timeValue
        minutLabel.text = (dateComponents.minute ?? 0).timeValue
        secondLabel.text = (dateComponents.second ?? 0).timeValue
    }

}
