//
//  ZoomingDelegates.swift
//  Enigma
//
//  Created by Aaryan Kothari on 01/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

extension PlayViewController : ZoomoutDelegate{
    
    func performZoom(){
        startingImageFrame = questionImageView.globalFrame
        let zoomingImageView = UIImageView(frame: self.startingImageFrame ?? CGRect())
        zoomingImageView.image = questionImageView.image
        zoomingImageView.contentMode = .scaleAspectFit
        var aspectRatio : CGFloat = 1
        
        backgroundView = ImageScrollView(frame: view.frame)
        backgroundView.setup()
        backgroundView?.backgroundColor = .dark
        backgroundView?.alpha = 0
        backgroundView.zoomOutDelegate = self
        view.addSubview(backgroundView!)
        view.addSubview(zoomingImageView)
        if let image = questionImageView.image {
            aspectRatio = image.size.width / image.size.height
        }
        let width = view.frame.width
        let center = view.center
        let height = width / aspectRatio
        UIView.animate(withDuration: 0.5, delay: 0,usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            zoomingImageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            zoomingImageView.center = center
            self.backgroundView?.alpha = 1
            self.delegate?.setShare(bool: true, image: zoomingImageView.image)
        }){ (completed : Bool) in
            self.questionImageView.alpha = 0.0
            zoomingImageView.isHidden = true
            if let image = self.questionImageView.image {
                self.backgroundView.display(image: image)
            }
        }
    }
    
    func didTapOnImage(imageScrollView: ImageScrollView, tap: UITapGestureRecognizer) {
        self.zoomout(tapGesture: tap)
    }
    
    @objc func zoomout(tapGesture: UITapGestureRecognizer){
        print("zoom  out")
        if  let zoomOutImageView = tapGesture.view{
            zoomOutImageView.isHidden = false
            zoomOutImageView.contentMode = .scaleAspectFit
            UIView.animate(withDuration: 0.5, delay: 0,usingSpringWithDamping: 1, initialSpringVelocity: 1 ,options: .curveEaseOut, animations: {
                zoomOutImageView.frame = self.startingImageFrame!
                self.backgroundView.backgroundColor = .clear
                self.questionImageView.alpha = 1.0
                self.delegate?.setShare(bool: false, image: nil)
            }) { (completed : Bool) in
                zoomOutImageView.removeFromSuperview()
                self.backgroundView?.removeFromSuperview()
            }
        }
    }

}
