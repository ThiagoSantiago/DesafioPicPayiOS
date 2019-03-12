//
//  ContactListInteractor.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/12/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

protocol ContactListInteractorProtocol {
    func getUsersList()
}

class ContactListInteractor: ContactListInteractorProtocol {
    private var presenter: ContactListPresenterProtocol?
    private var worker: ContactListWorker?
    
    private var usersData: [User] = []
    
    init(presenter: ContactListPresenterProtocol, worker: ContactListWorker = ContactListWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func getUsersList() {
        worker?.getUsersList(success: { result in
            self.presenter?.closeLoadingView()
            let viewModel = self.treatResultData(result: result)
            self.presenter?.presentUsers(list: viewModel)
        }, failure: { error in
            self.presenter?.closeLoadingView()
            self.presenter?.presentError(message: error.localizedDescription)
        })
    }
    
    private func treatResultData(result: UsersList) -> [UserViewModel] {
        
        return result.map { UserViewModel(name: $0.name,
                                          img: $0.img,
                                          username: $0.username)}
    }
}
