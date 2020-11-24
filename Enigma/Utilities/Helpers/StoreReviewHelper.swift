//
//  StoreReviewHelper.swift
//  Enigma
//
//  Created by Aaryan Kothari on 23/11/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation
import StoreKit

struct StoreReviewHelper {
    static func incrementAppOpenedCount() {
        if !Defaults.token().isEmpty{
            var appOpenCount = Defaults.appOpenCount()
            appOpenCount += 1
            UserDefaults.standard.set(appOpenCount, forKey: Keys.appOpenCount)
        }
    }
    
    static func checkAndAskForReview() {
        let appOpenCount = Defaults.appOpenCount()
        switch appOpenCount {
        case 3,50: //TODO 10
            incrementAppOpenedCount()
            StoreReviewHelper().requestReview()
        case _ where appOpenCount%100 == 0 :
            incrementAppOpenedCount()
            StoreReviewHelper().requestReview()
        default:
            if StoreReviewHelper().hackStarted(){
                StoreReviewHelper().requestReview()
                UserDefaults.standard.set(false, forKey: Keys.enigmaStarted)
            }
            print("App run count is : \(appOpenCount)")
            break
        }
        
    }
    
    fileprivate func hackStarted()->Bool{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        guard let hackOn = formatter.date(from: "2020/12/04 20:20") else {return false}
        let bool = Defaults.enigmaStarted()
        return (hackOn < Date()) && bool
    }
    
    fileprivate func requestReview() {
        SKStoreReviewController.requestReview()
    }
    
}
