//
//  PhotosSearchService.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/02/19.
//

import RxSwift

protocol PhotosSearchServiceType {
    func fetchPhotos(keyword: String?) -> Single<[Photo]>
}

struct PhotosSearchService: PhotosSearchServiceType {

    private let networkingManager: MoyaNetworkingManager<PhotosSearchAPI>

    init(networkingManager: MoyaNetworkingManager<PhotosSearchAPI>) {
        self.networkingManager = networkingManager
    }

    func fetchPhotos(keyword: String?) -> Single<[Photo]> {
        return self.networkingManager.rx.request(.searchedPhotos(keyword: keyword))
            .filterSuccessfulStatusCodes()
            .map([Photo].self, atKeyPath: "photos.photo")
    }
}
