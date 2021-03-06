//
//  PhotoSearchService.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/02/19.
//

import PhotoSearcherNetworking
import PhotoSearcherReactive
import PhotoSearcherFoundation

protocol PhotoSearchServiceType {
    func fetchPhotos(keyword: String?) -> Single<[Photo]>
}

struct PhotoSearchService: PhotoSearchServiceType {

    private let networkingManager: NetworkingManagerProtocol

    init(networkingManager: NetworkingManagerProtocol) {
        self.networkingManager = networkingManager
    }

    func fetchPhotos(keyword: String?) -> Single<[Photo]> {
        return self.networkingManager.request(FlickrAPI.searchedPhotos(keyword: keyword))
            .map([Photo].self, atKeyPath: "photos.photo")
            .catchError { error in
                logger.debugPrint("FAILURE: \(error)", level: .error)
                return Single.error(error)
            }
    }
}
