//
//  UIView+Extensions.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/12/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

enum SearchState {
    case active
    case inactive
}

extension UITextField {
    
    func addPlaceholderWith(imageName: String, text: String) {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)
        attachment.bounds = CGRect(x: 0, y: -3, width: 15, height: 15)
        
        let attachmentStr = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: "")
        myString.append(attachmentStr)
        let myString1 = NSMutableAttributedString(string: text)
        myString.append(myString1)
        
        self.attributedPlaceholder = myString

    }
    
    func setBorder(color: CGColor, width: CGFloat) {
        self.layer.borderColor = color
        self.layer.borderWidth = width
    }
    
    func changeLayoutBy(state: SearchState) {
        switch state {
        case .active:
            setBorder(color: UIColor.white.cgColor, width: 1)
            self.textAlignment = .left
            self.leftViewMode = .always
            self.clearButtonMode = .always
        case .inactive:
            setBorder(color: UIColor.white.cgColor, width: 0)
            self.textAlignment = .center
            self.leftViewMode = .never
            self.clearButtonMode = .never
        }
    }
}
