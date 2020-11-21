//
//  Image.swift
//  Enigma
//
//  Created by Aaryan Kothari on 28/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()


extension PlayViewController {
    
    func asyncLoadImage(_ qNumber:Int,_ url: String?, placeHolder: UIImage?,img: @escaping (UIImage,Int)->()) {
        
        
        guard let URLString = url else { return }
        self.activity.startAnimating()

        //If imageurl's imagename has space then this line going to work for this
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let cachedImage = imageCache.object(forKey: NSString(string: imageServerUrl)) {
            print("image was already cached!")
            img(cachedImage,qNumber)
            self.activity.stopAnimating()
            self.questionImageView.image = cachedImage
            return
        }
        
        self.questionImageView.image = nil
        
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

