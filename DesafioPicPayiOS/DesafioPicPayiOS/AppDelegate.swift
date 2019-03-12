//
//  AppDelegate.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/11/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let router = AppRouter.shared
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = router.navigation
        window?.makeKeyAndVisible()
        
        router.routeToHome()
        
        return true
    }

}

