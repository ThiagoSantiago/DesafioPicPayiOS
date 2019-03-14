//
//  PaymentPresenter.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/14/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

protocol PaymentPresenterProtocol {
    func closeLoadingView()
    func presentLoadingView()
    func presentSucces()
    func presentError(message: String)
}

class PaymentPresenter: PaymentPresenterProtocol {
    weak var viewController: PaymentViewProtocol?
    
    func closeLoadingView() {
        viewController?.hideLoadingView()
    }
    
    func presentLoadingView() {
        viewController?.showLoadingView()
    }
    
    func presentSucces() {
        viewController?.displaySucces()
    }
    
    func presentError(message: String) {
        viewController?.displayError(message: message)
    }
}
