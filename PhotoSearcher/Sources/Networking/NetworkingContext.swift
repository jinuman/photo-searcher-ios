//
//  NetworkingContext.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/02/16.
//

import Foundation

struct NetworkingContext {
    static var flickrBaseURL: URL {
        guard let urlString = Bundle.main.infoDictionary?["API_BASE_URL"] as? String,
              let url = URL(string: urlString)
        else {
            fatalError("FAIL: Load API_BASE_URL in Bundle")
        }
        return url
    }

    static var httpHeaders: [String: String] {
        return [:]
    }
}
