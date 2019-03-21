//
//  PaymentWorkerTests.swift
//  DesafioPicPayiOSTests
//
//  Created by Thiago Santiago on 3/21/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import XCTest
@testable import DesafioPicPayiOS

class PaymentWorkerTests: XCTestCase {
    var worker: PaymentWorker!
    var requester: PicPayApiRequestMock!
    
    override func setUp() {
        self.requester = PicPayApiRequestMock()
        self.worker = PaymentWorker(requester: self.requester)
    }
 
    func testShouldMakeAPaymentWithSuccess() {
        self.requester.isFailure = false
        self.requester.jsonData = "payment_approved"
        
        let user = UserViewModel(id: 1002, name: "Marina Coelho", img: "https://randomuser.me/api/portraits/women/37.jpg", username: "@marina.coelho")
        
        let card = Card(owner: "1002", cardNumber: "1111111111111111", securityCode: "789", expirationDate: "01/18")
        let paymentViewModel =  PaymentViewModel(card: card, value: "799", destinationUser: user)
        
        worker.makeAPayment(paymentData: paymentViewModel, success: { result in
            let payment = Payment(transaction: Transaction(id: 12314, value: "799", success: true, status: "Aprovada", timestamp: 1553145066, destinationUser: User(id: 1002, name: "Marina Coelho", img: "https://randomuser.me/api/portraits/women/37.jpg", username: "@marina.coelho")))
            
            XCTAssertNotNil(result)
            XCTAssertEqual(payment, result)
            XCTAssertTrue(result.transaction.success)
        }) { _ in
            XCTFail("Could not return the transaction result.")
        }
    }
    
    func testShouldMakeAPaymentWithError() {
        self.requester.isFailure = true
        self.requester.failureType = .badUrl
        
        let user = UserViewModel(id: 1002, name: "Marina Coelho", img: "https://randomuser.me/api/portraits/women/37.jpg", username: "@marina.coelho")
        
        let card = Card(owner: "1002", cardNumber: "1111111111111111", securityCode: "789", expirationDate: "01/18")
        let paymentViewModel =  PaymentViewModel(card: card, value: "799", destinationUser: user)
        
        worker.makeAPayment(paymentData: paymentViewModel, success: { _ in
            XCTFail("The test should to return an error.")
        }) { error in
            let errorMessage = "Bad URL request"
            
            XCTAssertNotNil(error)
            XCTAssertEqual(error, PicPayApiError.badUrl)
            XCTAssertEqual(errorMessage, error.localizedDescription)
        }
    }
    
    func testShouldMakeAPaymentWithSuccessButReprovedTransaction() {
        self.requester.isFailure = false
        self.requester.jsonData = "payment_repproved"
        
        let user = UserViewModel(id: 1002, name: "Marina Coelho", img: "https://randomuser.me/api/portraits/women/37.jpg", username: "@marina.coelho")
        
        let card = Card(owner: "1002", cardNumber: "1234123412341234", securityCode: "789", expirationDate: "01/18")
        let paymentViewModel =  PaymentViewModel(card: card, value: "799", destinationUser: user)
        
        worker.makeAPayment(paymentData: paymentViewModel, success: { _ in
            XCTFail("The test should to return an error.")
        }) { error in
            let errorMessage = "Operação recusada."
            
            XCTAssertNotNil(error)
            XCTAssertEqual(error, PicPayApiError.unknown(errorMessage))
            XCTAssertEqual(errorMessage, error.localizedDescription)
        }
    }
}
