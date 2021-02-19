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
        return self.networkingManager.rx.request(
            .searchedPhotos(keyword: keyword)
        )
        .map { $0.data }
        .map { data in
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                return try decoder.decode([Photo].self, from: data)
            } catch let error {
                print("Failed: \(error.localizedDescription)")
                return []
            }
        }
    }
}
