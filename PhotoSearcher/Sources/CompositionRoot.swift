//
//  CompositionRoot.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/02/06.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift

import Pure
import SnapKit
import Then

struct AppDependency {
    let rootViewController: UIViewController
}

enum CompositionRoot {
    static func resolve() -> AppDependency {
        // MARK: Networking

        // MARK: Photo Search

        let photoSearchViewController = PhotoSearchViewController()

        // MARK: Root View Controller

        let rootViewController = UINavigationController(rootViewController: photoSearchViewController)

        return AppDependency(rootViewController: rootViewController)
    }
}
