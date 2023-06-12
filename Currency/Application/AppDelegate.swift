//
//  AppDelegate.swift
//  Currency
//
//  Created by Khaled Bohout on 06/06/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setAppearance()
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()
        let coordinator = MainCoordinator(navigationController: navController)
        coordinator.start()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        return true
    }
}

