//
//  AppDelegate.swift
//  Enigma
//
//  Created by Aaryan Kothari on 29/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import Intents
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Defaults.fetchAll()
        requestSiri()
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    private func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
            guard let intent = userActivity.interaction?.intent as? LeaderboardIntent else {
                print("AppDelegate: Start Workout Intent - FALSE")
                return false
            }
            print("AppDelegate: Start Workout Intent - TRUE")
            print(intent)
            return true
        }
    
    func requestSiri(){
        INPreferences.requestSiriAuthorization { status in
          if status == .authorized {
            print("Hey, Siri!")
          } else {
            print("Nay, Siri!")
          }
        }
    }
}

