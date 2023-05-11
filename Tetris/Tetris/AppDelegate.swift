//
//  AppDelegate.swift
//  Tetris
//
//  Created by Sarvar Qosimov on 01/04/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = Test()
        window?.makeKeyAndVisible()
        
        return true
    }

    

}

