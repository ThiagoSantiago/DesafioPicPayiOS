//
//  ContacListCell.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/11/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

class ContactListCell: UITableViewCell {
    
    @IBOutlet private weak var userName: UILabel!
    @IBOutlet private weak var userNickname: UILabel!
    @IBOutlet private weak var userImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        super.setSelected(false, animated: true)
    }
    
    private func configViews() {
        userImage.layer.cornerRadius = 30
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 0.07, green: 0.78, blue: 0.44, alpha: 1)
        self.selectedBackgroundView = bgColorView
    }
    
    func setContent(user: UserViewModel) {
        userName.text = user.name
        userNickname.text = user.username
        userImage.loadImage(from: user.img)
    }
    
}
