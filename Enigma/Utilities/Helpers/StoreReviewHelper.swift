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
        case 5,50:
            incrementAppOpenedCount()
            StoreReviewHelper().requestReview()
        case _ where appOpenCount%100 == 0 :
            incrementAppOpenedCount()
            StoreReviewHelper().requestReview()
        default:
            break
            print("App run count is : \(appOpenCount)")
            break
        }
    }
    
    fileprivate func requestReview() {
        SKStoreReviewController.requestReview()
    }
    
}
