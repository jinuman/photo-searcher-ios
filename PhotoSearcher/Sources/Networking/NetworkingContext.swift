//
//  NetworkingContext.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/02/16.
//

import Foundation

struct NetworkingContext {
    static var flickrBaseURL: URL {
        guard let url = URL(string: "https://api.flickr.com") else {
            fatalError("Wrong host URL")
        }
        return url
    }

    static var httpHeaders: [String: String] {
        return [:]
    }
}
