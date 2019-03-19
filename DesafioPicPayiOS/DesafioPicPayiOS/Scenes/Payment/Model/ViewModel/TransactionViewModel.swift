//
//  TransactionViewModel.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/19/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

import Foundation

struct TransactionViewModel {
    let time: String
    let card: String
    let value: Double
    let userImg: String
    let username: String
    let transactionId: Int
}

extension TransactionViewModel: Equatable {
    static func == (lhs: TransactionViewModel, rhs: TransactionViewModel) -> Bool {
        return lhs.time == rhs.time &&
            lhs.card == rhs.card &&
            lhs.value == rhs.value &&
            lhs.userImg == rhs.userImg &&
            lhs.username == rhs.username &&
            lhs.transactionId == rhs.transactionId
    }
}
