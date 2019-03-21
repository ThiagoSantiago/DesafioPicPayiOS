//
//  PaymentPresenterMock.swift
//  DesafioPicPayiOSTests
//
//  Created by Thiago Santiago on 3/21/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

@testable import DesafioPicPayiOS

class PaymentPresenterMock: PaymentPresenter {
    var viewModel: TransactionViewModel?
    var loadingPresented: Bool = false
    var errorWasPresented: Bool = false
    var closeLoadingPresented: Bool = false
    var transactionSuccessPresented: Bool = false
    
    override func closeLoadingView() {
        closeLoadingPresented = true
    }
    
    override func presentLoadingView() {
        loadingPresented = true
    }
    
    override func presentSucces(transaction: TransactionViewModel) {
        viewModel = transaction
        transactionSuccessPresented = true
    }
    
    override func presentError(message: String) {
        errorWasPresented = true
    }
}


