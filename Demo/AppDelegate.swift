//
//  AppDelegate.swift
//  Demo
//
//  Created by Nghi Phan on 2/18/20.
//  Copyright © 2020 Artsy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let _window = UIWindow(frame: UIScreen.main.bounds)
        _window.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
        self.window = _window
        _window.makeKeyAndVisible()
        return true
    }

}

