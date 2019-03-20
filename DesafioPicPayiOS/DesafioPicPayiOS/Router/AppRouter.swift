//
//  AppRouter.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/11/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

class AppRouter {
    
    static let shared = AppRouter()
    
    var navigation: UINavigationController = UINavigationController()
    
    func routeToHome() {
        let presenter = ContactListPresenter()
        let interactor = ContactListInteractor(presenter: presenter)
        self.navigation.navigationBar.isHidden = true
        let viewController = ContactsListViewController(interactor: interactor)
        
        presenter.viewController = viewController
        self.navigation.pushViewController(viewController, animated: false)
    }
    
    func routeToNewCard() {
        let viewController = NewCardViewController()
        self.navigation.pushViewController(viewController, animated: true)
    }
    
    func routeToRegisterNewCard() {
        let presenter = RegisterCardPresenter()
        let interactor = RegisterCardInteractor(presenter: presenter)
        let viewController = RegisterNewCardViewController(interactor: interactor)
        
        presenter.viewController = viewController
        self.navigation.pushViewController(viewController, animated: true)
    }
    
    func routeToPayment(_ viewModel: PaymentViewModel) {
        let presenter = PaymentPresenter()
        let interactor = PaymentInteractor(presenter: presenter)
        let viewController = PaymentViewController(interactor: interactor, viewModel: viewModel)
        
        presenter.viewController = viewController
        self.navigation.pushViewController(viewController, animated: false)
    }
    
    func popToHome(with viewModel: TransactionViewModel) {
        for controller in navigation.viewControllers as Array {
            if controller.isKind(of: ContactsListViewController.self) {
                guard let vc = controller as? ContactsListViewController else {
                    break
                }
                vc.displayTransactionRecipt(viewModel)
                navigation.popToViewController(vc, animated: true)
                break
            }
        }
    }
    
    func popViewController() {
        self.navigation.popViewController(animated: true)
    }
}
