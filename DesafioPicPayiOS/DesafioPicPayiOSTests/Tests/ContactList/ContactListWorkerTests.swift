//
//  ContactListWorkerTests.swift
//  DesafioPicPayiOSTests
//
//  Created by Thiago Santiago on 3/20/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import XCTest
@testable import DesafioPicPayiOS

class ContactListWorkerTests: XCTestCase {
    var worker: ContactListWorker!
    var requester: PicPayApiRequestMock!

    override func setUp() {
        self.requester = PicPayApiRequestMock()
        self.worker = ContactListWorker(requester: self.requester)
    }
    
    func testShouldGetTheListOfUsersWithSuccess() {
        self.requester.isFailure = false
        self.requester.jsonData = "users"
        
        worker.getUsersList(success: { result in
            let user = User(id: 1001, name: "Eduardo Santos", img: "https://randomuser.me/api/portraits/men/9.jpg", username: "@eduardo.santos")

            guard let firstUser = result.first else {
                XCTFail("Could not return the list of users.")
                return
            }
            
            XCTAssertNotNil(result)
            XCTAssertEqual(user, firstUser)
        }) { _ in
            XCTFail("Could not return the list of users.")
        }
    }
    
    func testShouldGetTheListOfUsersWithError() {
        self.requester.isFailure = true
        self.requester.failureType = .badUrl
        
        worker.getUsersList(success: { _ in
             XCTFail("The test should to return an error.")
        }) { error in
            let errorMessage = "Bad URL request"
            
            XCTAssertNotNil(error)
            XCTAssertEqual(error, PicPayApiError.badUrl)
            XCTAssertEqual(errorMessage, error.localizedDescription)
        }
    }
    
    func testShouldSearchForAnUserWithSuccess() {
        self.requester.isFailure = false
        self.requester.jsonData = "users"
        
        let nameToSearch = "mar"
        let totalOfResults = 7
        let firstUserFound = User(id: 1002, name: "Marina Coelho", img: "https://randomuser.me/api/portraits/women/37.jpg", username: "@marina.coelho")
        
        worker.getUsersList(success: { _ in }) { _ in }
        worker.seachUser(name: nameToSearch) { result in
            XCTAssertNotNil(result)
            XCTAssertEqual(totalOfResults, result.count)
            XCTAssertEqual(firstUserFound, result.first)
        }
    }
    
    func testShouldSearchForAnEmptyUser() {
        self.requester.isFailure = false
        self.requester.jsonData = "users"
        
        let nameToSearch = "       "
        let totalOfResults = 33
        let firstUserFound = User(id: 1001, name: "Eduardo Santos", img: "https://randomuser.me/api/portraits/men/9.jpg", username: "@eduardo.santos")
        
        
        worker.getUsersList(success: { _ in }) { _ in }
        worker.seachUser(name: nameToSearch) { result in
            XCTAssertNotNil(result)
            XCTAssertEqual(totalOfResults, result.count)
            XCTAssertEqual(firstUserFound, result.first)
        }
    }
    
    func testShouldSearchForAnUserWithNotFound() {
        self.requester.isFailure = false
        self.requester.jsonData = "users"
        
        let nameToSearch = "khsdfkshdaf"
        let totalOfResults = 0
        
        worker.getUsersList(success: { _ in }) { _ in }
        worker.seachUser(name: nameToSearch) { result in
            XCTAssertNotNil(result)
            XCTAssertEqual(totalOfResults, result.count)
        }
    }
}
