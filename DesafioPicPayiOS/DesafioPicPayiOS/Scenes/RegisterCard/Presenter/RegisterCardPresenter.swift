//
//  RegisterCardPresenter.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/20/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

protocol RegisterCardPresenterProtocol {
    func presentCardSaved(success: Bool)
    func presentCardRetrieved(card: Card)
}

class RegisterCardPresenter: RegisterCardPresenterProtocol {
    weak var viewController: RegisterCardViewProtocol?
    
    func presentCardSaved(success: Bool) {
        viewController?.displayCardSaved(success: success)
    }
    
    func presentCardRetrieved(card: Card) {
        viewController?.displayCardRetrieved(card: card)
    }
}
