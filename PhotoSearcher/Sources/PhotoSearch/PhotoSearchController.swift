//
//  PhotoSearchController.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 02/04/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit

class PhotoSearchController: UIViewController {
    
    // MARK:- Properties
    private lazy var viewModel: PhotoSearchViewModel = PhotoSearchViewModel()
    
    private let flickrAPI = FlickrAPI.shared
    private let cellId = "photoCellId"
    
    // MARK:- Screen Properties
    private lazy var photoSearchBar: UISearchBar = {
        let sb = UISearchBar(frame: .zero)
        sb.placeholder = "검색어를 입력하세요.."
        sb.searchBarStyle = .prominent
        sb.barTintColor = .black
        let textFieldInsideSearchBar = sb.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        sb.delegate = self
        return sb
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.dataSource = self
        cv.delegate = self
        cv.register(PhotoCell.self, forCellWithReuseIdentifier: cellId)
        return cv
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK:- Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flickr Photo Search"
        view.backgroundColor = .black
        
        setupSubviews()
        
        searchFlickr(with: "fruit")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        photoSearchBar.text = nil
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK:- Screen layout methods
    private func setupSubviews() {
        [photoSearchBar, collectionView].forEach {
            view.addSubview($0)
        }
        
        let guide = view.safeAreaLayoutGuide
        
        photoSearchBar.anchor(top: guide.topAnchor,
                              leading: guide.leadingAnchor,
                              bottom: nil,
                              trailing: guide.trailingAnchor)
        
        collectionView.anchor(top: photoSearchBar.bottomAnchor,
                              leading: guide.leadingAnchor,
                              bottom: guide.bottomAnchor,
                              trailing: guide.trailingAnchor)
    }
    
    // MARK:- Handling methods
    private func searchFlickr(with query: String) {
        let query = query.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+")
        
        if query.isEmpty {
            let alert = flickrAPI.displayAlert(with: "검색어를 입력 안하셨어요..ㅎㅎ")
            self.present(alert, animated: true, completion: nil)
            self.photoSearchBar.text = nil
            return
        }
        
        guard let searchUrl = flickrAPI.searchUrl(with: query) else { return }
        
        flickrAPI.flickrSearch(with: searchUrl) { [weak self] (photos, err) in
            if let err = err {
                print("Failed to fetch flickr data: \(err.localizedDescription)")
                return
            }
            guard
                let self = self,
                let photos = photos else { return }
            // DI
            self.viewModel = PhotoSearchViewModel(photos: photos)
            
            DispatchQueue.main.async {
                self.collectionView.reloadSections(IndexSet(0...0))
                if !photos.isEmpty {
                    let indexPath: IndexPath = IndexPath(item: 0, section: 0)
                    self.collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.bottom, animated: false)
                }
            }
        }
    }
}

// MARK:- Regarding Collection View methods
extension PhotoSearchController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PhotoCell else {
            fatalError("Failed to cast PhotoCell")
        }
        cell.imageUrl = viewModel.imageUrl(for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height / 2.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoDetailController = PhotoDetailController()
        // DI
//        photoDetailController.imageUrl = viewModel.imageUrl(for: indexPath)
        let photo = viewModel.photo(for: indexPath)
        photoDetailController.viewModel = PhotoDetailViewModel(photo: photo)
        navigationController?.pushViewController(photoDetailController, animated: true)
    }
}

// MARK:- Regarding UISearchBarDelegate methods
extension PhotoSearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        searchFlickr(with: query)
    }
}
