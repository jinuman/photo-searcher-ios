//
//  Constants.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 02/04/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import Foundation

struct Constants {
//    static let baseURL = "https://api.flickr.com/services/rest/"
    
    static let APIScheme = "https"
    static let APIHost = "api.flickr.com"
    static let APIPath = "/services/rest"
    
    static let APIparameters = [
        "method" : "flickr.photos.search",
        "api_key" : FlickrConfig.apiKey,
        "sort" : "relevance",
        "per_page" : "10",
        "format" : "json",
        "nojsoncallback" : "1",
        "extras" : "url_m"
    ]
}
