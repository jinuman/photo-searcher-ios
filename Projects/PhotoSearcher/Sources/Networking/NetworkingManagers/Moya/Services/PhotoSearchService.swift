//
//  PhotoSearchService.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/02/19.
//

import RxSwift

protocol PhotoSearchServiceType {
    func fetchPhotos(keyword: String?) -> Single<[Photo]>
}

struct PhotoSearchService: PhotoSearchServiceType {

    private let networkingManager: NetworkingManager<PhotoSearchAPI>

    init(networkingManager: NetworkingManager<PhotoSearchAPI>) {
        self.networkingManager = networkingManager
    }

    func fetchPhotos(keyword: String?) -> Single<[Photo]> {
        return self.networkingManager.rx.request(.searchedPhotos(keyword: keyword))
            .filterSuccessfulStatusCodes()
            .map([Photo].self, atKeyPath: "photos.photo")
    }
}
