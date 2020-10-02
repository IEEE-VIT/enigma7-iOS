//
//  Image.swift
//  Enigma
//
//  Created by Aaryan Kothari on 28/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()


extension UIImageView {
    
    func asyncLoadImage(_ url: String?, placeHolder: UIImage?) {
        
        
        self.image = nil
        guard let URLString = url else { return }

        //If imageurl's imagename has space then this line going to work for this
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let cachedImage = imageCache.object(forKey: NSString(string: imageServerUrl)) {
            print("image was already cached!")
            self.image = cachedImage
            return
        }
        
        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                //print("RESPONSE FROM API: \(response)")
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL:"+(error?.localizedDescription ?? ""))
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: imageServerUrl))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}

