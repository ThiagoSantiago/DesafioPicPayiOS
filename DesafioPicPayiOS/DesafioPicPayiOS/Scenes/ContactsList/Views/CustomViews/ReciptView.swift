//
//  ReciptView.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/19/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

class ReciptView: UIView {
    @IBOutlet private weak var userName: UILabel!
    @IBOutlet private weak var cardLabel: UILabel!
    @IBOutlet private weak var totalValue: UILabel!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var transactionId: UILabel!
    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet private weak var transactionDate: UILabel!
    @IBOutlet private weak var cardDebitedAmount: UILabel!

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
    
    func setContent(_ data: TransactionViewModel) {
        let last4Numbers = data.card.suffix(4)
        
        userName.text = data.username
        transactionDate.text = data.time
        totalValue.text = "R$ \(data.value)"
        userImage.loadImage(from: data.userImg)
        cardDebitedAmount.text = "R$ \(data.value)"
        cardLabel.text = "Mastercard \(last4Numbers)"
        transactionId.text = "Transação: \(data.transactionId)"
    }
}
