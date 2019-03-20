//
//  ReciptView.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/19/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

class ReciptView: UIView {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var userImage: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("ReciptView", owner: self, options: nil)
        addSubview(containerView)
        
        userImage.layer.cornerRadius = 50
    }

}
