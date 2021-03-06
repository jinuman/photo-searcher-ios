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

        let resolver = self.container.synchronize()

        // MARK: Networking

        self.container.register(NetworkingManagerProtocol.self) {
            _ in NetworkingManager(
                requestClosure: MoyaProvider<MultiSugarTarget>.defaultRequestMapping,
                plugins: [
                    NetworkingErrorHandlingPlugin()
                ]
            )
        }


        // MARK: Service

        self.container.autoregister(
            PhotoSearchServiceType.self,
            initializer: PhotoSearchService.init
        )


        // MARK: Photo Search

        self.container.autoregister(
            PhotoSearchViewController.Factory.self,
            dependency: PhotoSearchViewController.Dependency.init
        )
        self.container.autoregister(
            PhotoDetailViewReactor.Factory.self,
            dependency: PhotoDetailViewReactor.Dependency.init
        )
        self.container.autoregister(
            PhotoDetailViewController.Factory.self,
            dependency: PhotoDetailViewController.Dependency.init
        )

        let photoSearchViewReactorFactory = PhotoSearchViewReactor.Factory(dependency: .init(
            photoSearchService: resolver.resolve()
        ))
        let photoSearchViewControllerFactory = PhotoSearchViewController.Factory(dependency: .init(
            photoDetailViewReactorFactory: resolver.resolve(),
            photoDetailViewControllerFactory: resolver.resolve()
        ))
        let photoSearchViewController = photoSearchViewControllerFactory.create(payload: .init(
            reactor: photoSearchViewReactorFactory.create()
        ))


        // MARK: Root View Controller

        let rootViewController = UINavigationController(rootViewController: photoSearchViewController)

        try! container.verify()

        return AppDependency(rootViewController: rootViewController)
    }
}

extension Resolver {
    public func resolve<Service>() -> Service! {
        return self.resolve(Service.self)
    }
}
