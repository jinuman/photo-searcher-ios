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
        
        return true
    }

}

