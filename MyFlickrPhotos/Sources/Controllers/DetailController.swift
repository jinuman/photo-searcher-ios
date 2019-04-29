//
//  DetailController.swift
//  MyFlickrPhotos
//
//  Created by Jinwoo Kim on 02/04/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    // MARK:- Logic properties
    let service = Service.shared
    var imageUrl: String?
    
    // MARK:- View Properties
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentMode = .scaleToFill
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.autoresizesSubviews = true
        
        scrollView.clipsToBounds = true
        
        scrollView.maximumZoomScale = 5.0
        scrollView.minimumZoomScale = 1.0
        
        return scrollView
    }()
    
    let detailImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    // MARK:- Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        view.backgroundColor = .black
        view.clipsToBounds = true
        
        setupScrollViewForDetailImage()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_save_white_24pt"), style: .plain, target: self, action: #selector(handleSave))
        
        guard let imageUrl = imageUrl else { return }
        detailImageView.loadImageUsingCache(with: imageUrl)
    }
    
    deinit {
        print("DetailController \(#function)")
    }
    
    // MARK:- Handling methods
    @objc fileprivate func handleSave() {
        guard let imageToSave = detailImageView.image else { return }
        let alertController = UIAlertController(title: nil,
                                                message: "사진을 아이폰에 저장 하시겠습니까?",
                                                preferredStyle: .actionSheet)
        
        let saveAction = UIAlertAction(title: "저장", style: .default) { [weak self] (_) in
            guard let self = self else { return }
            UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        alertController.view.addSubview(UIView()) // error disappear
        present(alertController, animated: false, completion: nil)
    }
    
    @objc fileprivate func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let alertController = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        } else {
            let alertController = UIAlertController(title: "저장 확인", message: "사진 앱에 저장되었습니다.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        }
    }
    
    // MARK:- Layout methods
    fileprivate func setupScrollViewForDetailImage() {
        view.addSubview(scrollView)
        scrollView.delegate = self
        
        let guide = view.safeAreaLayoutGuide
        
        scrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        
        scrollView.addSubview(detailImageView)
        
        detailImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        detailImageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
    }
}

// MARK:- Regarding UIScrollViewDelegate methods
extension DetailController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.detailImageView
    }
}
