//
//  PhotoSearchAPI.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/02/19.
//

import Moya

enum PhotosSearchAPI {
    case searchedPhotos(
            apiKey: String = FlickrConfig.apiKey,
            method: String = "flickr.photos.search",
            format: String? = "json",
            noJSONCallback: String? = "1",
            perPage: String? = "10",
            sort: String? = "relevance",
            extras: String? = "url_m",
            keyword: String?
         )
}

extension PhotosSearchAPI: BaseTargetType {
    var route: Route {
        return .get("/services/rest")
    }

    var parameters: Parameters? {
        switch self {
        case let .searchedPhotos(
            apiKey,
            method,
            format,
            noJSONCallback,
            perPage,
            sort,
            extras,
            keyword
        ):
            return URLEncoding() => [
                "api_key": apiKey,
                "method": method,
                "format": format,
                "nojsoncallback": noJSONCallback,
                "per_page": perPage,
                "sort": sort,
                "extras": extras,
                "text": keyword,
                "tags": keyword
            ]
        }
    }
}
