//
//  PhotoSearchViewModel.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 02/04/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import Foundation

import RxSwift

class PhotoSearchViewModel {
    // MARK: - Properties

    private let photos: [Photo]

    let disposeBag = DisposeBag()

    // MARK: - Dependency Injection (DI)

    init(photos: [Photo] = []) {
        self.photos = photos
        let networkingManager = NetworkingManager<PhotoSearchAPI>()
        let service = PhotoSearchService(networkingManager: networkingManager)
        service.fetchPhotos(keyword: nil)
            .subscribe({
                print($0)
            })
            .disposed(by: self.disposeBag)
    }

//    private let service: PhotosSearchServiceType

    func addService(service: PhotoSearchServiceType) {
//        self.service = service
    }

    func run() {
//        let networkingManager = MoyaNetworkingManager<PhotosSearchAPI>()
//        let service = PhotosSearchService(networkingManager: networkingManager)
//        service.fetchPhotos(keyword: "fruit")
//            .debug("viewModel")
//            .subscribe({
//                print($0)
//            })
//            .disposed(by: self.disposeBag)
    }

    // MARK: - Handling methods

    func photo(for indexPath: IndexPath) -> Photo {
        return photos[indexPath.row]
    }

    func numberOfItems() -> Int {
        return photos.count
    }

    func imageUrl(for indexPath: IndexPath) -> String {
        let photo = self.photo(for: indexPath)
        return photo.url
    }
}
