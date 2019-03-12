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
    @IBOutlet private weak var searchbar: UISearchBar!

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
        
        searchBarCenterInit()
    }
    
    private func searchBarCenterInit(){
        if let searchBarTextField = searchbar.value(forKey: "searchField") as? UITextField {
            
            //Center search text
//            searchBarTextField.textAlignment = .center
            
            //Center placeholder
            let width = searchbar.frame.width / 2 - (searchBarTextField.attributedPlaceholder?.size().width)!
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: searchbar.frame.height))
            searchBarTextField.leftView = paddingView
            searchBarTextField.leftViewMode = .unlessEditing
        }
    }
}
