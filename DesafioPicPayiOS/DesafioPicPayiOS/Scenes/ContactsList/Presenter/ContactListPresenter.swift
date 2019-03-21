//
//  ContactListPresenter.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/12/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

protocol ContactListPresenterProtocol {
    func closeLoadingView()
    func presentLoadingView()
    func presentError(message: String)
    func presentCardSaved(cardSaved: Card?)
    func presentUsers(list: [UserViewModel])
}

class ContactListPresenter: ContactListPresenterProtocol {
    weak var viewController: ContactListProtocol?
    
    func closeLoadingView() {
        DispatchQueue.main.async {
            self.viewController?.hideLoadingView()
        }
    }
    
    func presentLoadingView() {
        viewController?.displayLoadingView()
    }
    
    func presentError(message: String) {
        DispatchQueue.main.async {
            self.viewController?.displayError(message)
        }
    }
    
    func presentCardSaved(cardSaved: Card?) {
        viewController?.displayCardSaved(cardSaved)
    }
    
    func presentUsers(list: [UserViewModel]) {
        DispatchQueue.main.async {
            self.viewController?.displayUsers(list)
        }
    }
}
