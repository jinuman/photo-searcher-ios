//
//  PhotoSearchViewReactor.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/03/02.
//

import PhotoSearcherFoundation
import PhotoSearcherReactive

final class PhotoSearchViewReactor: Reactor, FactoryModule {

    // MARK: - Module

    struct Dependency {
        let photoSearchService: PhotoSearchServiceType
    }

    enum Action {
        case refresh
        case searchPhotos(keyword: String?)
    }

    enum Mutation {
        case setRefreshing(Bool)
        case setKeyword(String?)
        case setPhotos([Photo])
        case updateSections
    }

    struct State {
        var isRefreshing: Bool = false
        var isLoading: Bool = false
        var keyword: String?
        var photos: [Photo] = []
        var sections: [PhotoSearchViewSection] = []
    }


    // MARK: - Properties

    private let dependency: Dependency
    let initialState: State
    let shouldScrollToTop: Observable<Void>
    private let shouldScrollToTopRelay = PublishRelay<Void>()
    private let defaultKeyword: String = "fruit"


    // MARK: - Initializing

    init(dependency: Dependency, payload: Payload) {
        defer { _ = self.state }
        self.dependency = dependency
        self.initialState = State()
        self.shouldScrollToTop = self.shouldScrollToTopRelay
            .asObservable()
            .share(replay: 1, scope: .whileConnected)
    }


    // MARK: - Methods

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            guard !self.currentState.isRefreshing,
                  !self.currentState.isLoading else { return .empty() }
            let currentKeyword = self.currentState.keyword == nil
                ? self.defaultKeyword
                : self.currentState.keyword
            return .concat([
                .just(.setRefreshing(true)),
                self.fetchPhotos(with: currentKeyword),
                .just(.setRefreshing(false)),
                .just(.updateSections)
            ])

        case let .searchPhotos(keyword):
            guard !self.currentState.isRefreshing,
                  !self.currentState.isLoading else { return .empty() }
            return .concat([
                .just(.setRefreshing(true)),
                self.fetchPhotos(with: keyword),
                .just(.setRefreshing(false)),
                .just(.updateSections)
            ])
        }
    }

    private func fetchPhotos(with keyword: String?) -> Observable<Mutation> {
        return self.dependency.photoSearchService.fetchPhotos(keyword: keyword)
            .asObservable()
            .map(Mutation.setPhotos)
            .do(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.shouldScrollToTopRelay.accept(())
            })
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case let .setRefreshing(isRefreshing):
            newState.isRefreshing = isRefreshing

        case let .setKeyword(keyword):
            newState.keyword = keyword

        case let .setPhotos(photos):
            newState.photos = photos

        case .updateSections:
            newState.sections = [
                self.photoItemSection(state: state)
            ]
            .compactMap { $0 }
        }
        return newState
    }

    private func photoItemSection(state: State) -> PhotoSearchViewSection? {
        let sectionItems: [PhotoSearchViewSection.Item] = state.photos.map { .photoItem($0) }
        return PhotoSearchViewSection(identity: .photoItem, items: sectionItems)
    }
}
