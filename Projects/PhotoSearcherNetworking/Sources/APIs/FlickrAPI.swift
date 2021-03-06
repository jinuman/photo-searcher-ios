//
//  FlickrAPI.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/02/19.
//

public enum FlickrAPI {
    case searchedPhotos(
            apiKey: String = Self.apiKey,
            method: String = "flickr.photos.search",
            format: String? = "json",
            noJSONCallback: String? = "1",
            perPage: String? = "20",
            sort: String? = "relevance",
            extras: String? = "url_m",
            keyword: String?
         )
}

extension FlickrAPI: SugarTargetType {
    public var route: Route {
        return .get("/services/rest")
    }

    public var parameters: Parameters? {
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

    public var baseURL: URL {
        return NetworkingContext.flickrBaseURL
    }

    public var headers: [String: String]? {
        return [
            "Accept": "application/json"
        ]
    }

    public var sampleData: Data {
        return Data()
    }
}

public extension FlickrAPI {
    static var apiKey: String {
        return "0f18de6414ffd1f343be617041839163"
    }
    static var secret: String {
        return "261749dbff492ef7"
    }
}
