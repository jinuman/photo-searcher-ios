//
//  PhotoDetailViewReactor.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/03/04.
//

import PhotoSearcherFoundation
import PhotoSearcherReactive

final class PhotoDetailViewReactor: Reactor, FactoryModule {

    // MARK: - Module

    struct Dependency {
    }

    struct Payload {
        let photo: Photo
    }

    typealias Action = NoAction

    struct State {
        let photoURLString: String?
    }


    // MARK: - Properties

    let initialState: State


    // MARK: - Initializing

    init(dependency: Dependency, payload: Payload) {
        defer { _ = self.state }
        self.initialState = State(
            photoURLString: payload.photo.url
        )
    }
}
