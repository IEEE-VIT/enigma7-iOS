//
//  Image.swift
//  Enigma
//
//  Created by Aaryan Kothari on 28/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

// NSCache
let imageCache = NSCache<NSString, UIImage>()


extension PlayViewController {
    
    //MARK: --- DOWNLOAD QUESTION IMAGE ASYNCHRONOUSLY ---
    func asyncLoadImage(_ qNumber:Int,_ url: String?, placeHolder: UIImage?,img: @escaping (UIImage,Int)->()) {
        
        guard let URLString = url else { return } // check if URLstring is valid
        self.activity.startAnimating() // animate activity indicator

        //If imageurl's imagename has space then this line going to work for this
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        // if image is already cached do not downlaod again
        if let cachedImage = imageCache.object(forKey: NSString(string: imageServerUrl)) {
            print("image was already cached!")
            img(cachedImage,qNumber)
            self.activity.stopAnimating()
            self.questionImageView.image = cachedImage
            return
        }
        
        // empty imageView
        self.questionImageView.image = nil
        
        // check if URL is valid
        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                print((response as? HTTPURLResponse)?.statusCode as Any)
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL:"+(error?.localizedDescription ?? ""))
                    DispatchQueue.main.async {
                        self.activity.stopAnimating()
                        self.questionImageView.image = placeHolder
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: imageServerUrl))
                            img(downloadedImage,qNumber)
                            self.activity.stopAnimating()
                            self.questionImageView.image = downloadedImage
                            print("SUCCESSFULLY DOWNLOADED IMAGE")
                        }
                    }
                }
            }).resume()
        }
    }
}

