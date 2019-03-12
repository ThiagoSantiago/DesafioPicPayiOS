//
//  PicPaygetUsersSetup.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/12/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

enum PicPayContactListServiceSetup: PicPayApiSetupProtocol {
    
    case getUsers()
    
    var endpoint: String {
        switch self {
            
        case .getUsers():
            let url = Constants.baseUrl+"/tests/mobdev/users"
            
            return url
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers():
            return .get
        }
    }
}
