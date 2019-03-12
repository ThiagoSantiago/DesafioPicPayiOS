//
//  UserViewModel.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/12/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

struct UserViewModel {
    let name: String
    let img: String
    let username: String
}

extension UserViewModel: Equatable {
    static func ==(lhs: UserViewModel, rhs: UserViewModel) -> Bool {
        return lhs.name == rhs.name &&
        lhs.img == rhs.img &&
        lhs.username == rhs.username
    }
}
