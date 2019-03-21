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
    var time: String
    var card: String
    var value: String
    var userImg: String
    var username: String
    var transactionId: Int
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
