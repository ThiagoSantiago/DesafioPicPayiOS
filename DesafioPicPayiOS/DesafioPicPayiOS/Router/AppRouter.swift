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
    
    func popViewController() {
        self.navigation.popViewController(animated: true)
    }
}
