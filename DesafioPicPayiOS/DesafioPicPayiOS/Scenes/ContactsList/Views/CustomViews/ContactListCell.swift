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
        userImage.layer.cornerRadius = 35
    }
    
    func setContent(user: UserViewModel) {
        self.userName.text = user.name
        self.userNickname.text = user.username
    }
    
}
