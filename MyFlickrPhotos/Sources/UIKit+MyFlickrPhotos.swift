//
//  UIKit+MyFlickrPhotos.swift
//  MyFlickrPhotos
//
//  Created by Jinwoo Kim on 02/04/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func loadImageUsingCache(with urlString: String) {
        self.image = nil
        
        // Check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            return
        }
        
        // Otherwise fire off a new download
        guard let url = URL(string: urlString) else {
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                guard let downloadedImage = UIImage(data: data) else {
                    return
                }
                imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                self.image = downloadedImage
            }
        }
        task.resume()
    }
}
