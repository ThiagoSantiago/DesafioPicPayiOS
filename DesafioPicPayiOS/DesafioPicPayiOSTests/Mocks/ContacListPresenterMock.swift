//
//  ContacListPresenterMock.swift
//  DesafioPicPayiOSTests
//
//  Created by Thiago Santiago on 3/20/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

@testable import DesafioPicPayiOS


class ContactListPresenterMock: ContactListPresenter {
    var card: Card?
    var viewModel: [UserViewModel]?
    var loadingPresented: Bool = false
    var errorWasPresented: Bool = false
    var usersListPresented: Bool = false
    var closeLoadingPresented: Bool = false
    
    override func closeLoadingView() {
        closeLoadingPresented = true
    }
    
    override func presentLoadingView() {
        loadingPresented = true
    }
    
    override func presentError(message: String) {
        errorWasPresented = true
    }
    
    override func presentUsers(list: [UserViewModel]) {
        viewModel = list
        usersListPresented = true
    }
    
    override func presentCardSaved(cardSaved: Card?) {
        card = cardSaved
    }
}
