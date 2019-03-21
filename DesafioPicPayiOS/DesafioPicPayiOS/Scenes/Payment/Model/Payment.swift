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
