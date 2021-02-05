//
//  PhotoSearchViewModel.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 02/04/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import Foundation

class PhotoSearchViewModel {
    // MARK:- Properties
    private let photos: [Photo]
    
    // MARK:- Dependency Injection (DI)
    init(photos: [Photo] = []) {
        self.photos = photos
    }
    
    // MARK:- Handling methods
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
