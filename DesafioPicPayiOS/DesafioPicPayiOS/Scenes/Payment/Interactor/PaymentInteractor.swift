//
//  PaymentInteractor.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/14/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

protocol PaymentInteractorProtocol {
    func makeApayment()
}

class PaymentInteractor: PaymentInteractorProtocol {
    private var presenter: PaymentPresenterProtocol?
    private var worker: PaymentWorker?
    
    init(presenter: PaymentPresenterProtocol, worker: PaymentWorker = PaymentWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func makeApayment() {
        presenter?.presentLoadingView()
        worker?.makeAPayment(success: {
            DispatchQueue.main.async {
                self.presenter?.closeLoadingView()
                self.presenter?.presentSucces()
            }
        }, failure: { error in
            DispatchQueue.main.async {
                self.presenter?.closeLoadingView()
                self.presenter?.presentError(message: error.localizedDescription)
            }
        })
    }
}
