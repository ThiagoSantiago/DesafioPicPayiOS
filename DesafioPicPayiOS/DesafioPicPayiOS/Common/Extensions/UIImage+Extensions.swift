//
//  UIImage+Extensions.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/12/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(from url: String) {
        guard let urlPath = URL(string: url) else { return }
        
        self.image = UIImage(named: "user_placeholder")
        
        ImageDownloader.shared.loadImage(from: urlPath) { [weak self] (image) in
            guard let image = image else { return }
            self?.alpha = 0
            self?.image = image
            UIView.animate(withDuration: 0.2, animations: {
                self?.alpha = 1
            })
        }
    }
    
    func paddingImageContent() -> UIImageView{
        if let size = self.image?.size {
            self.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 20.0, height: size.height)
        }
        
        self.contentMode = UIView.ContentMode.center
        
        return self
    }
}

extension UIImage {
    func imageResize (sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }

}


