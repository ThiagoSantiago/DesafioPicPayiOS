//
//  ContactListWorker.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/12/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

class ContactListWorker {
    typealias Failure = (_ error: PicPayApiError) -> Void
    
    let requester: PicPayApiRequestProtocol
    
    init(requester: PicPayApiRequestProtocol = PicPayApiRequest()) {
        self.requester = requester
    }
    
    typealias GetUsersListSuccess = (_ movies: UsersList) -> Void
    func getUsersList(success: @escaping GetUsersListSuccess, failure: @escaping Failure) {
        
        requester.request(PicPayContactListServiceSetup.getUsers()) { result in
            switch result{
            case let .success(data):
                
                do {
                    let decoder = JSONDecoder()
                    let userssList = try decoder.decode(UsersList.self, from: data)
                    
                    success(userssList)
                } catch {
                    failure(.couldNotParseObject)
                }
            case let .failure(error):
                failure(error)
            }
        }
    }
}
