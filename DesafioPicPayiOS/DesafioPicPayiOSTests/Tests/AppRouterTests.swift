//
//  AppRouterTests.swift
//  DesafioPicPayiOSTests
//
//  Created by Thiago Santiago on 3/20/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import XCTest
@testable import DesafioPicPayiOS

class AppRouterTests: XCTestCase {
    var router: AppRouter!
    var navigationController: UINavigationController!

    override func setUp() {
        navigationController = UINavigationController()
        router = AppRouter.shared
        router.navigation = navigationController
    }

    func testWhenCallRouteToHomeThenNavigationPushContactListViewController() {
        router.routeToHome()
        
        XCTAssertEqual(router.navigation, navigationController)
        XCTAssertTrue(
            router.navigation.viewControllers.first!.isKind(of: ContactsListViewController.self)
        )
    }
    
    func testWhenCallRouteToNewCardNavigationPushNewCardViewController() {
        let viewModel = UserViewModel(id: 1001, name: "Eduardo Santos", img: "https://randomuser.me/api/portraits/men/9.jpg", username: "@eduardo.santos")
        
        router.routeToNewCard(user: viewModel)
        
        XCTAssertEqual(router.navigation, navigationController)
        XCTAssertTrue(
            router.navigation.viewControllers.first!.isKind(of: NewCardViewController.self)
        )
    }
    
    func testWhenCallRouteToRegisterNewCardNavigationPushRegisterNewCardViewController() {
        let user = UserViewModel(id: 1002, name: "Marina Coelho", img: "https://randomuser.me/api/portraits/women/37.jpg", username: "@marina.coelho")
        
        let card = Card(owner: "1002", cardNumber: "1234123412341234", securityCode: "789", expirationDate: "01/18")
        let paymentViewModel =  PaymentViewModel(card: card, value: "799", destinationUser: user)
        
        router.routeToRegisterNewCard(viewModel: paymentViewModel)
        
        XCTAssertEqual(router.navigation, navigationController)
        XCTAssertTrue(
            router.navigation.viewControllers.first!.isKind(of: RegisterNewCardViewController.self)
        )
    }
    
    func testWhenCallRouteToPaymentNavigationPushPaymentViewController() {
        let user = UserViewModel(id: 1002, name: "Marina Coelho", img: "https://randomuser.me/api/portraits/women/37.jpg", username: "@marina.coelho")
        
        let card = Card(owner: "1002", cardNumber: "1234123412341234", securityCode: "789", expirationDate: "01/18")
        let paymentViewModel =  PaymentViewModel(card: card, value: "799", destinationUser: user)
        
        router.routeToPayment(paymentViewModel)
        
        XCTAssertEqual(router.navigation, navigationController)
        XCTAssertTrue(
            router.navigation.viewControllers.first!.isKind(of: PaymentViewController.self)
        )
    }
    
    func testWhenCallPopViewControllerThenNavigationPopTheTopViewController() {
         let viewModel = UserViewModel(id: 1001, name: "Eduardo Santos", img: "https://randomuser.me/api/portraits/men/9.jpg", username: "@eduardo.santos")
        
        router.routeToHome()
        router.routeToNewCard(user: viewModel)
        router.popViewController()
        
        XCTAssertEqual(router.navigation, navigationController)
        XCTAssertTrue(
            router.navigation.viewControllers.first!.isKind(of: ContactsListViewController.self)
        )
    }
}
