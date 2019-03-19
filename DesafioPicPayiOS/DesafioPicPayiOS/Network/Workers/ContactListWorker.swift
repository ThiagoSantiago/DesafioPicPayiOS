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
    var users: UsersList = []
    
    init(requester: PicPayApiRequestProtocol = PicPayApiRequest()) {
        self.requester = requester
    }
    
    typealias GetUsersListSuccess = (_ movies: UsersList) -> Void
    func getUsersList(success: @escaping GetUsersListSuccess, failure: @escaping Failure) {
        
        if users.isEmpty {
            requester.request(PicPayContactListServiceSetup.getUsers()) { result in
                switch result{
                case let .success(data):
                    
                    do {
                        let decoder = JSONDecoder()
                        let userssList = try decoder.decode(UsersList.self, from: data)
                        self.users = userssList
                        success(userssList)
                    } catch {
                        failure(.couldNotParseObject)
                    }
                case let .failure(error):
                    failure(error)
                }
            }
        } else {
            success(users)
        }
    }
    
    typealias UsersFilteredResult = (_ users: [User]) -> Void
    func seachUser(name: String, completion: @escaping UsersFilteredResult ) {
        var filteredData = users
        let trimmedString = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedString != ""{
            filteredData = users.filter { $0.name.contains(name) || $0.username.contains(name)}
        }
        
        completion(filteredData)
    }
}
