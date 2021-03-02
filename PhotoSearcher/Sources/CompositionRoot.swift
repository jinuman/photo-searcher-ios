//
//  CompositionRoot.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/02/06.
//

import PhotoSearcherFoundation
import PhotoSearcherUI
import PhotoSearcherNetworking
import PhotoSearcherReactive

struct AppDependency {
    let rootViewController: UIViewController
}

enum CompositionRoot {
    static func resolve() -> AppDependency {
        // MARK: Networking

        // MARK: Photo Search

        let photoSearchViewController = LegacyPhotoSearchViewController()

        // MARK: Root View Controller

        let rootViewController = UINavigationController(rootViewController: photoSearchViewController)

        return AppDependency(rootViewController: rootViewController)
    }
}
