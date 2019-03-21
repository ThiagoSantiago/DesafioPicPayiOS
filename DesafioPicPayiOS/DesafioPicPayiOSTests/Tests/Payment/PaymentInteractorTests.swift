//
//  PaymentInteractorTests.swift
//  DesafioPicPayiOSTests
//
//  Created by Thiago Santiago on 3/21/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import XCTest
@testable import DesafioPicPayiOS

class PaymentInteractorTests: XCTestCase {
    var worker: PaymentWorker!
    var requester: PicPayApiRequestMock!
    var interactor: PaymentInteractor!
    var presenter: PaymentPresenterMock!
    
    override func setUp() {
        self.requester = PicPayApiRequestMock()
        self.presenter = PaymentPresenterMock()
        self.worker = PaymentWorker(requester: self.requester)
        self.interactor = PaymentInteractor(presenter: self.presenter, worker: self.worker)
    }

    func testShouldPresnetTheTransactionDataWhenWorkerReturnsSuccess() {
        requester.isFailure = false
        self.requester.jsonData = "payment_approved"
        
        let user = UserViewModel(id: 1002, name: "Marina Coelho", img: "https://randomuser.me/api/portraits/women/37.jpg", username: "@marina.coelho")
        
        let card = Card(owner: "1002", cardNumber: "1111111111111111", securityCode: "789", expirationDate: "01/18")
        let paymentViewModel =  PaymentViewModel(card: card, value: "799", destinationUser: user)
        
        interactor.makeApayment(with: paymentViewModel)
        
        let transactionViewModel = TransactionViewModel(time: "21/03/2019 às 02:11", card: "1111111111111111", value: "799", userImg: "https://randomuser.me/api/portraits/women/37.jpg", username: "@marina.coelho", transactionId: 12314)
        
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { (timer) in
            XCTAssertTrue(self.presenter.loadingPresented)
            XCTAssertFalse(self.presenter.errorWasPresented)
            XCTAssertTrue(self.presenter.closeLoadingPresented)
            XCTAssertTrue(self.presenter.transactionSuccessPresented)
            XCTAssertEqual(transactionViewModel, self.presenter.viewModel)
        }
    }
    
    func testShouldPresnetTheTransactionDataWhenWorkerReturnsError() {
        requester.isFailure = true
        
        let user = UserViewModel(id: 1002, name: "Marina Coelho", img: "https://randomuser.me/api/portraits/women/37.jpg", username: "@marina.coelho")
        
        let card = Card(owner: "1002", cardNumber: "1111111111111111", securityCode: "789", expirationDate: "01/18")
        let paymentViewModel =  PaymentViewModel(card: card, value: "799", destinationUser: user)
        
        interactor.makeApayment(with: paymentViewModel)
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { (timer) in
            XCTAssertTrue(self.presenter.loadingPresented)
            XCTAssertFalse(self.presenter.transactionSuccessPresented)
            XCTAssertTrue(self.presenter.closeLoadingPresented)
            XCTAssertTrue(self.presenter.errorWasPresented)
        }
    }
}
