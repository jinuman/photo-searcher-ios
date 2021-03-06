//
//  Photo.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/02/23.
//

import PhotoSearcherFoundation

struct Photo: Decodable, ModelType, Hashable {
    let id: String
    let title: String
    let owner: String
    let secret: String?
    let server: String?
    let farm: Int?
    let isPublic: Int?
    let isFriend: Int?
    let isFamily: Int?
    let url: String?
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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.owner = try container.decode(String.self, forKey: .owner)

        self.secret = try container.decodeIfPresent(String.self, forKey: .secret)
        self.server = try container.decodeIfPresent(String.self, forKey: .server)
        self.farm = try container.decodeIfPresent(Int.self, forKey: .farm)
        self.isPublic = try container.decodeIfPresent(Int.self, forKey: .isPublic)
        self.isFriend = try container.decodeIfPresent(Int.self, forKey: .isFriend)
        self.isFamily = try container.decodeIfPresent(Int.self, forKey: .isFamily)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.height = try container.decodeIfPresent(Int.self, forKey: .height)
        self.width = try container.decodeIfPresent(Int.self, forKey: .width)
    }
}

extension Photo {
    static var defaultImage: UIImage {
        return R.image.image_placeholder()?.withRenderingMode(.alwaysOriginal) ?? .init()
    }
}
