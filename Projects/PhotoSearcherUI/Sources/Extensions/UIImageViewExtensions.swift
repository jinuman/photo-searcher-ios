//
//  UIImageViewExtensions.swift
//  PhotoSearcherFoundation
//
//  Created by Jinwoo Kim on 2021/03/06.
//

private var imageCache = [String: UIImage]()

public extension UIImageView {
    func loadImageUsingCache(with urlString: String) {
        image = nil

        // Check cache for image first
        if let cachedImage = imageCache[urlString] {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            return
        }

        // Otherwise fire off a new download
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            let photoImage = UIImage(data: data)

            imageCache[url.absoluteString] = photoImage
            DispatchQueue.main.async {
                self.image = photoImage
            }
        }
        task.resume()
    }
}
