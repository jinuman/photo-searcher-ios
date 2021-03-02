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
    static var container = Container(defaultObjectScope: .container)

    static func resolve() -> AppDependency {

        // MARK: Networking

        // MARK: Photo Search

        self.container.autoregister(
            PhotoSearchViewController.Factory.self,
            dependency: PhotoSearchViewController.Dependency.init
        )

        let photoSearchViewReactorFactory = PhotoSearchViewReactor.Factory(
            dependency: .init()
        )
        let photoSearchViewControllerFactory = PhotoSearchViewController.Factory(
            dependency: .init()
        )
        let photoSearchViewController = photoSearchViewControllerFactory.create(payload: .init(
            reactor: photoSearchViewReactorFactory.create()
        ))

        // MARK: Root View Controller

        let rootViewController = UINavigationController(rootViewController: photoSearchViewController)

        return AppDependency(rootViewController: rootViewController)
    }
}
