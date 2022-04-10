//
//  AppDelegate.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/09.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let rootVC = MovieListVC()
        let navi = UINavigationController(rootViewController: rootVC)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = navi
        window?.makeKeyAndVisible()
        
        return true
    }
}

