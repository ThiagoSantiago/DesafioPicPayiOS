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
}
