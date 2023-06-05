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
       // window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()

        return true
    }
}

