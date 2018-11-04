//
//  SearchCollectionViewCell.swift
//  PhotoSearcherApp
//
//  Created by Jinwoo Kim on 2018. 11. 4..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit
import Kingfisher

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var url: String? {
        didSet {
            if let url = url {
                setImage(url: url)
            }
        }
    }
    
    func setImage(url: String) {
        let imageUrl = URL(string: url)
        self.imageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "image_placeholder"))
    }
}
