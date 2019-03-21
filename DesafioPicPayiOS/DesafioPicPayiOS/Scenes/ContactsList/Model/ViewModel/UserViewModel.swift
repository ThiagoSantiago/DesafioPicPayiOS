//
//  UserViewModel.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/12/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

struct UserViewModel {
    let id: Int
    let name: String
    let img: String
    let username: String
}

extension UserViewModel: Equatable {
    static func ==(lhs: UserViewModel, rhs: UserViewModel) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.img == rhs.img &&
               lhs.username == rhs.username
    }
}
