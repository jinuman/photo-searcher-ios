//
//  AppDelegate.swift
//  MyFlickrPhotos
//
//  Created by Jinwoo Kim on 02/04/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Thread.sleep(forTimeInterval: 1.3)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            let photoVC = PhotoController()
            window.rootViewController = UINavigationController(rootViewController: photoVC)
            window.makeKeyAndVisible()
        }
        
        customizeNavigationBar()
        
        return true
    }
    
    private func customizeNavigationBar() {
        if let navController = window?.rootViewController as? UINavigationController {
            navController.navigationBar.prefersLargeTitles = true
            navController.navigationBar.barStyle = .black
            navController.navigationBar.tintColor = .white      // BarButton color
            navController.navigationBar.isTranslucent = false   // 바 투명도 설정 X
        }
    }

}

