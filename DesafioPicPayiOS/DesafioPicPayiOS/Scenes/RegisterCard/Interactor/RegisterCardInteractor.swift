//
//  RegisterCardInteractor.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/20/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

protocol RegisterCardInteractorProtocol {
    func saveCard(_ card: Card)
    func loadCard()
}

class RegisterCardInteractor: RegisterCardInteractorProtocol {
    private var presenter: RegisterCardPresenterProtocol?
    private var worker: KeychainServiceWorker?
    
    init(presenter: RegisterCardPresenterProtocol, worker: KeychainServiceWorker = KeychainServiceWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func saveCard(_ card: Card) {
        if let savedWithSuccess = worker?.saveCard(card) {
            presenter?.presentCardSaved(success: savedWithSuccess)
        }
    }
    
    func loadCard() {
        if let cardRetrieved = worker?.loadCard() {
            presenter?.presentCardRetrieved(card: cardRetrieved)
        }
    }
}
