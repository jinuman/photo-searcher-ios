//
//  UIKit+PhotoSearcher.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 02/04/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit

private var imageCache = [String: UIImage]()

extension UIImageView {
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

extension UIColor {
  // swiftlint:disable identifier_name
  convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
    self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
  }

  // swiftlint:enable identifier_name
}

extension UIView {
  func anchor(top: NSLayoutYAxisAnchor?,
              leading: NSLayoutXAxisAnchor?,
              bottom: NSLayoutYAxisAnchor?,
              trailing: NSLayoutXAxisAnchor?,
              padding: UIEdgeInsets = .zero,
              size: CGSize = .zero)
  {
    translatesAutoresizingMaskIntoConstraints = false

    if let top = top {
      topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
    }

    if let leading = leading {
      leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
    }

    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
    }

    if let trailing = trailing {
      trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
    }

    if size.width != 0 {
      widthAnchor.constraint(equalToConstant: size.width).isActive = true
    }

    if size.height != 0 {
      heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
  }

  func fillSuperview(padding: UIEdgeInsets = .zero) {
    translatesAutoresizingMaskIntoConstraints = false
    guard let superview = superview else { return }
    topAnchor.constraint(equalTo: superview.topAnchor, constant: padding.top).isActive = true

    leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding.left).isActive = true

    bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding.bottom).isActive = true

    trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding.right).isActive = true

    widthAnchor.constraint(equalTo: superview.widthAnchor).isActive = true
    heightAnchor.constraint(equalTo: superview.heightAnchor).isActive = true
  }

  func centerInSuperview(size: CGSize = .zero) {
    translatesAutoresizingMaskIntoConstraints = false
    guard let superview = superview else { return }

    centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
    centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true

    if size.width != 0 {
      widthAnchor.constraint(equalToConstant: size.width).isActive = true
    }

    if size.height != 0 {
      heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
  }

  func centerXInSuperview() {
    translatesAutoresizingMaskIntoConstraints = false
    guard let superview = superview else { return }
    centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
  }

  func centerYInSuperview() {
    translatesAutoresizingMaskIntoConstraints = false
    guard let superview = superview else { return }
    centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
  }

  func constrainWidth(constant: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    widthAnchor.constraint(equalToConstant: constant).isActive = true
  }

  func constrainHeight(constant: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: constant).isActive = true
  }
}
