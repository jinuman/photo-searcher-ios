//
//  PhotoController.swift
//  MyFlickrPhotos
//
//  Created by Jinwoo Kim on 02/04/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit

class PhotoController: UIViewController {
    
    // MARK:- Properties
    let photoSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = .black
        searchBar.placeholder = "검색어를 입력하세요.."
        return searchBar
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .black
        return cv
    }()
    
    // MARK:- Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo Search"
        view.backgroundColor = .black
        view.clipsToBounds = true
        
        [photoSearchBar, collectionView].forEach {
            view.addSubview($0)
        }
        
        setupViewAutoLayouts()
    }
    
    // MARK:- Setup layout methods
    fileprivate func setupViewAutoLayouts() {
        let guide = view.safeAreaLayoutGuide
        photoSearchBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        photoSearchBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        photoSearchBar.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        photoSearchBar.bottomAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        
        collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
    }
}
