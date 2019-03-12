//
//  User.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/12/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

typealias UsersList = [User]

struct User {
    let id: Int
    let name: String
    let img: String
    let username: String
}

extension User: Decodable {}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.img == rhs.img &&
            lhs.username == rhs.username
    }
}
