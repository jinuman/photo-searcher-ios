//
//  PhotoCollectionViewCell.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/03/04.
//

import PhotoSearcherUI

final class PhotoItemCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    private let photoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.image = Photo.defaultImage
    }


    // MARK: - Initializing

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
    }

    private func initialize() {
        self.contentView.addSubview(photoImageView)

        self.photoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }


    // MARK: - Configuring

    func configure(with imageURLString: String?) {
        if let imageURLString = imageURLString {
            self.photoImageView.loadImageUsingCache(with: imageURLString)
        } else {
            self.photoImageView.image = Photo.defaultImage
        }
    }
}
