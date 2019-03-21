//
//  ContactListInteractorTests.swift
//  DesafioPicPayiOSTests
//
//  Created by Thiago Santiago on 3/21/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import XCTest
@testable import DesafioPicPayiOS

class ContactListInteractorTests: XCTestCase {
    var worker: ContactListWorker!
    var requester: PicPayApiRequestMock!
    var interactor: ContactListInteractor!
    var presenter: ContactListPresenterMock!
    
    override func setUp() {
        self.requester = PicPayApiRequestMock()
        self.presenter = ContactListPresenterMock()
        self.worker = ContactListWorker(requester: self.requester)
        self.interactor = ContactListInteractor(presenter: self.presenter, worker: self.worker)
    }
    
    func testShouldGetListOfUsersWhenWorkerReturnsError() {
        requester.isFailure = true
        interactor.getUsersList()
        
        XCTAssertTrue(presenter.loadingPresented)
        XCTAssertFalse(presenter.usersListPresented)
        XCTAssertTrue(presenter.closeLoadingPresented)
        XCTAssertTrue(presenter.errorWasPresented)
    }
    
    func testShouldPresentListOfUsersWhenWorkerReturnsSuccess() {
        requester.isFailure = false
        self.requester.jsonData = "users"
        
        interactor.getUsersList()
        
        let viewModel = UserViewModel(id: 1001, name: "Eduardo Santos", img: "https://randomuser.me/api/portraits/men/9.jpg", username: "@eduardo.santos")
        
        XCTAssertTrue(presenter.loadingPresented)
        XCTAssertTrue(presenter.usersListPresented)
        XCTAssertTrue(presenter.closeLoadingPresented)
        XCTAssertFalse(presenter.errorWasPresented)
        XCTAssertEqual(viewModel, presenter.viewModel?.first!)
    }
    
    func testShouldSearchAnUserWhenWorkerReturnsAnEmptyList() {
        requester.isFailure = false
        self.requester.jsonData = "users"
        let totalResults = 0
        
        interactor.getUsersList()
        interactor.searchUsers(name: "kasjdfjks")
        
        XCTAssertTrue(presenter.loadingPresented)
        XCTAssertTrue(presenter.usersListPresented)
        XCTAssertFalse(presenter.errorWasPresented)
        XCTAssertTrue(presenter.closeLoadingPresented)
        XCTAssertEqual(totalResults, presenter.viewModel?.count)
    }
    
    func testShouldSearchAnUserWhenWorkerReturnsAListofUsers() {
        requester.isFailure = false
        self.requester.jsonData = "users"
        let totalResults = 7
        
        interactor.getUsersList()
        interactor.searchUsers(name: "mar")
        
        let viewModel = UserViewModel(id: 1002, name: "Marina Coelho", img: "https://randomuser.me/api/portraits/women/37.jpg", username: "@marina.coelho")
        
        XCTAssertTrue(presenter.loadingPresented)
        XCTAssertTrue(presenter.usersListPresented)
        XCTAssertFalse(presenter.errorWasPresented)
        XCTAssertTrue(presenter.closeLoadingPresented)
        XCTAssertEqual(viewModel, presenter.viewModel?.first!)
        XCTAssertEqual(totalResults, presenter.viewModel?.count)
    }
}
