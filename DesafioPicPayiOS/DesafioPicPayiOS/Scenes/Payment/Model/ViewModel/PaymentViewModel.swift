//
//  PaymentViewModel.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/20/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

struct PaymentViewModel {
    var card: Card?
    var value: String?
    var destinationUser: UserViewModel
}

extension PaymentViewModel: Equatable {
    static func == (lhs: PaymentViewModel, rhs: PaymentViewModel) -> Bool {
        return lhs.card == rhs.card &&
               lhs.value == rhs.value &&
               lhs.destinationUser == rhs.destinationUser
    }
}
