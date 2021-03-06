//
//  PhotoSearchViewSection.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/03/04.
//

import PhotoSearcherReactive

struct PhotoSearchViewSection: Equatable {
    enum Identity: Hashable {
        case photoItem
    }

    var identity: Identity
    var items: [Item]
}

extension PhotoSearchViewSection: AnimatableSectionModelType {
    enum Item: Hashable {
        case photoItem(Photo)
    }

    init(original: PhotoSearchViewSection, items: [Item]) {
        self = original
        self.items = items
    }
}

extension PhotoSearchViewSection.Item: IdentifiableType {
    var identity: Int {
        return self.hashValue
    }
}
