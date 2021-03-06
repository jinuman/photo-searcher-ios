//
//  PhotoSearchViewReactor.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/03/02.
//

import PhotoSearcherFoundation
import PhotoSearcherReactive

final class PhotoSearchViewReactor: Reactor, FactoryModule {

    // MARK: Module

    struct Dependency {
    }

    enum Action {
    }

    enum Mutation {
    }

    struct State {
    }


    // MARK: Properties

    let initialState: State


    // MARK: Initializing

    init(dependency: Dependency, payload: Payload) {
        defer { _ = self.state }
        self.initialState = State()
    }
}
