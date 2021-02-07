//
//  PhotoDetailViewModel.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 26/05/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import Foundation

class PhotoDetailViewModel {
    private let photo: Photo

    var imageUrl: String {
        return photo.url
    }

    init(photo: Photo) {
        self.photo = photo
    }
}
