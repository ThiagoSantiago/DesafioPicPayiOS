//
//  Payment.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/18/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

struct Payment: Decodable {
    let transaction: Transaction
}

struct Transaction: Decodable {
    let id: Int
    let value: String
    let success: Bool
    let status: String
    let timestamp: Int
    let destinationUser: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case value
        case status
        case success
        case timestamp
        case destinationUser = "destination_user"
    }
}

extension Payment: Equatable {
    static func == (lhs: Payment, rhs: Payment) -> Bool {
        return lhs.transaction == rhs.transaction
    }
}

extension Transaction: Equatable {
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.id == rhs.id &&
        lhs.value == rhs.value &&
        lhs.status == rhs.status &&
        lhs.success == rhs.success &&
        lhs.timestamp == rhs.timestamp &&
        lhs.destinationUser == rhs.destinationUser
    }
}

