//
//  AppDelegate.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 02/04/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties

    var window: UIWindow?
    var dependency: AppDependency

    // MARK: Initializing

    override private init() {
        dependency = CompositionRoot.resolve()
        super.init()
    }

    // MARK: Methods

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        Thread.sleep(forTimeInterval: 1.3)

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = dependency.rootViewController
        window.makeKeyAndVisible()
        self.window = window

        self.customizeNavigationBar()

        return true
    }

    private func customizeNavigationBar() {
        guard let navigationController = window?.rootViewController as? UINavigationController else { return }

        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.isTranslucent = false // 바 투명도 설정 X
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.tintColor = .white // BarButton color
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
