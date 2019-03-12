//
//  HeaderView.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/11/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var searchbar: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit(){
        Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
        addSubview(contentView)
        
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        searchbar.layer.cornerRadius = 20
        searchbar.addPlaceholderWith(imageName: "search_icon", text: "  A quem você deseja pagar?")
        
        let searchActive = UIImageView(image: UIImage(named: "search_active_icon")).paddingImageContent()
        let clearImage = UIImage(named: "icon_clear")?.imageResize(sizeChange: CGSize(width: 10.0, height: 10.0))
        
        if let clearButton = searchbar.value(forKeyPath: "_clearButton") as? UIButton {
            clearButton.frame = CGRect(x: 0.0, y: 0.0, width: 10, height: 10)
            clearButton.setImage(clearImage, for: .normal)
            clearButton.setImage(clearImage, for: .highlighted)
        }
        
        searchbar.leftView = searchActive
        searchbar.delegate = self
    }
}

extension HeaderView: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        searchbar.changeLayoutBy(state: .active)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchbar.changeLayoutBy(state: .inactive)
    }
}
