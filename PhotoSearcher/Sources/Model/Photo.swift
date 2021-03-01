//
//  Photo.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/02/23.
//

struct Photo: Decodable, ModelType {
    let url: String
    let id: String
    let title: String
    let owner: String
    let secret: String?
    let server: String?
    let farm: Int?
    let isPublic: Int?
    let isFriend: Int?
    let isFamily: Int?
    let height: Int?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, owner, secret, server, farm

        case isPublic = "ispublic"
        case isFriend = "isfriend"
        case isFamily = "isfamily"
        case url = "url_m"
        case height = "height_m"
        case width = "width_m"
    }
}
