//
//  Service.swift
//  MyFlickrPhotos
//
//  Created by Jinwoo Kim on 02/04/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit

class Service {
    // MARK:- Singleton property
    static let shared = Service()
    
    // MARK:- Helper methods
    func alertController(with message: String) -> UIAlertController {
        let alertController = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        return alertController
    }
    
    func queryItems(with parameters: [String : String]) -> [URLQueryItem] {
        return parameters.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
    }
    
    func searchUrl(with text: String) -> URL? {
        var components = URLComponents()
        components.scheme = Constants.APIScheme
        components.host = Constants.APIHost
        components.path = Constants.APIPath
        
        components.queryItems = self.queryItems(with: Constants.APIparameters)
        
        components.queryItems?.append(URLQueryItem(name: "text", value: text))
        components.queryItems?.append(URLQueryItem(name: "tags", value: text))
        return components.url
    }
    
    func flickrSearch(with searchURL: URL, completion: @escaping ([Photo]?, Error?) -> ()) {
        // Make session and perform the request
        let session = URLSession.shared
        let request = URLRequest(url: searchURL)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            // Check task error
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            // Check response status code
            if
                let statusCode = (response as? HTTPURLResponse)?.statusCode,
                (statusCode < 200 || statusCode > 300) {
                print("Server returned an error")
                return
            }
            
            // Check data returned
            guard let data = data else {
                print("No data was returned by request")
                return
            }
            
            // Parse the data
//            let jsonString = String(data: data, encoding: .utf8)
//            print(jsonString!)
            do {
                let flickr = try JSONDecoder().decode(Flickr.self, from: data)
                let photos: [Photo] = flickr.photos.photo
                print("\nphoto URL: \(photos[0].url)")
                completion(photos, nil)
            } catch let jsonError {
                print("Failed to decode: ", jsonError.localizedDescription)
            }
        }
        task.resume()
    }
}
