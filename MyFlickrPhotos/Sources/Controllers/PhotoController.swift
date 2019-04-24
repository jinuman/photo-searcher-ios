//
//  PhotoController.swift
//  MyFlickrPhotos
//
//  Created by Jinwoo Kim on 02/04/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit

class PhotoController: UIViewController {
    
    // MARK:- Logic properties
    private let service = Service.shared
    lazy var viewModel: PhotoViewModel = PhotoViewModel()
    private let cellId = "cellId"
    
    // MARK:- View Properties
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
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
        
        photoSearchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: cellId)
        
        searchFlickr(with: "wave")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        photoSearchBar.text = nil
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK:- Handling methods
    fileprivate func searchFlickr(with searchQuery: String) {
        let query = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+")
        
        if query.isEmpty {
            let alert = service.displayAlert(with: "검색어를 입력 안하셨어요..ㅎㅎ")
            self.present(alert, animated: true, completion: nil)
            self.photoSearchBar.text = nil
            return
        }
        
        guard let searchUrl = service.searchUrl(with: query) else {
            return
        }
        print("\nsearch URL: \(searchUrl)")
        service.flickrSearch(with: searchUrl) { [weak self] (photos, err) in
            if let err = err {
                print("Failed to fetch flickr data: ", err.localizedDescription)
                return
            }
            guard
                let self = self,
                let photos = photos else { return }
            // DI
            self.viewModel = PhotoViewModel(photos: photos)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                let indexPath: IndexPath = IndexPath(item: 0, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.bottom, animated: false)
            }
        }
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

// MARK:- Regarding Collection View methods
extension PhotoController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PhotoCell else {
            fatalError("Photo cell is bad")
        }
        cell.viewModel = viewModel.photoCellViewModel(for: indexPath)
        return cell
    }
}

extension PhotoController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let halfOfHeight = collectionView.frame.height / 2
        return CGSize(width: halfOfHeight, height: halfOfHeight)
    }
}

extension PhotoController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailController()
        // DI
        detailVC.imageUrl = viewModel.imageUrl(for: indexPath)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK:- Regarding UISearchBarDelegate methods
extension PhotoController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchFlickr(with: text)
    }
}
