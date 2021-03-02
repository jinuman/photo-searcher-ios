//
//  PhotoSearchViewController.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/03/02.
//

import PhotoSearcherUI
import PhotoSearcherReactive

final class PhotoSearchViewController: BaseViewController, View, FactoryModule {

    internal typealias Reactor = PhotoSearchViewReactor

    // MARK: Module

    struct Dependency {

    }

    struct Payload {
        let reactor: Reactor
    }


    // MARK: Initializing

    init(dependency: Dependency, payload: Payload) {
        super.init()
    }


    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func bind(reactor: Reactor) {
    }
}
