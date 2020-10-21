//
//  Image.swift
//  EnigmaWatch Extension
//
//  Created by Aaryan Kothari on 21/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation
import WatchKit


public extension WKInterfaceImage {

public func setBackgroundImage(url: String?) {
    guard let url = url else { return }
    
    let asyncQueue = DispatchQueue(label: "backgroundImage")
    asyncQueue.async {
        do {
            if let url = URL(string: url) {
                let data = try Data(contentsOf: url)
                if let placeholder = UIImage(data: data) {
                    self.setImage(placeholder)
                }
            }
        } catch let error {
            print("Could not set backgroundImage for WKInterfaceImage: \(error.localizedDescription)")
        }
    }
}

}
