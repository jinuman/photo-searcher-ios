//
//  Flickr.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 02/04/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import Foundation

struct Flickr: Codable {
    let photos: Photos
    let stat: String
}

struct Photos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photo: [Photo]
}

struct Photo: Codable {
    let url: String
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
    let height: String
    let width: String
    
    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title
        case ispublic, isfriend, isfamily
        case url = "url_m"
        case height = "height_m"
        case width = "width_m"
    }
}
