//
//  PaymentViewModel.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/20/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

struct PaymentViewModel {
    let cardNumber: String = "1111111111111111"
    let securityCode: Int = 789
    let value: Double = 79.9
    let expiryDate: String = "01/08"
    let destinationUser: Int = 1002
}

extension PaymentViewModel: Equatable {
    static func == (lhs: PaymentViewModel, rhs: PaymentViewModel) -> Bool {
        return lhs.cardNumber == rhs.cardNumber &&
            lhs.securityCode == rhs.securityCode &&
            lhs.value == rhs.value &&
            lhs.expiryDate == rhs.expiryDate &&
            lhs.destinationUser == rhs.destinationUser
    }
}
