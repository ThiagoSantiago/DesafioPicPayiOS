//
//  Card.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/20/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

struct Card {
    let owner: String
    let cardNumber: String
    let securityCode: String
    let expirationDate: String
}

extension Card: Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.owner == rhs.owner &&
            lhs.cardNumber == rhs.cardNumber &&
            lhs.securityCode == rhs.securityCode &&
            lhs.expirationDate == rhs.expirationDate
    }
}
