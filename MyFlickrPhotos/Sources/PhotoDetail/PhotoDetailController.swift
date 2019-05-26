//
//  PhotoDetailController.swift
//  MyFlickrPhotos
//
//  Created by Jinwoo Kim on 02/04/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit

class PhotoDetailController: UIViewController {
    
    // MARK:- Properties
    var viewModel: PhotoDetailViewModel?
    
    // MARK:- Screen Properties
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.contentMode = .scaleToFill
        sv.clipsToBounds = true
        
        sv.alwaysBounceVertical = false
        sv.alwaysBounceHorizontal = false
        sv.showsVerticalScrollIndicator = true
        sv.showsHorizontalScrollIndicator = true
        sv.autoresizesSubviews = false
        
        sv.maximumZoomScale = 3.0
        sv.minimumZoomScale = 1.0
        sv.delegate = self
        return sv
    }()
    
    private let photoDetailImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    // MARK:- Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo Detail"
        view.backgroundColor = .black
        
        setupSubviews()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_save_white_24pt"), style: .plain, target: self, action: #selector(handleSave))
        
        guard let viewModel = viewModel else { return }
        photoDetailImageView.loadImageUsingCache(with: viewModel.imageUrl)
    }
    
    deinit {
        print("DetailController \(#function)")
    }
    
    // MARK:- Screen layout methods
    fileprivate func setupSubviews() {
        let guide = view.safeAreaLayoutGuide
        view.addSubview(scrollView)
        
        scrollView.anchor(top: guide.topAnchor,
                          leading: guide.leadingAnchor,
                          bottom: guide.bottomAnchor,
                          trailing: guide.trailingAnchor)
        
        scrollView.addSubview(photoDetailImageView)
        
        photoDetailImageView.centerInSuperview()
    }
    
    // MARK:- Handling methods
    @objc private func handleSave() {
        guard let imageToSave = photoDetailImageView.image else { return }
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
    
    @objc private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let alertController = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        } else {
            savedFeedback()
        }
    }
    
    private func savedFeedback() {
        DispatchQueue.main.async {
            let savedLabel = UILabel()
            savedLabel.text = "사진 앱에\n저장되었습니다."
            savedLabel.textColor = .white
            savedLabel.textAlignment = .center
            savedLabel.font = UIFont.boldSystemFont(ofSize: 18)
            savedLabel.numberOfLines = 0
            savedLabel.backgroundColor = UIColor(white: 0, alpha: 0.3)
            
            self.view.addSubview(savedLabel)
            savedLabel.centerInSuperview(size: CGSize(width: 150, height: 100))
            
            savedLabel.layer.transform = CATransform3DMakeScale(0, 0, 0)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                
                savedLabel.layer.transform = CATransform3DMakeScale(1, 1, 1)
                
            }, completion: { (completed) in
                
                UIView.animate(withDuration: 0.5, delay: 1.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    
                    savedLabel.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
                    savedLabel.alpha = 0
                    
                }, completion: { (_) in
                    savedLabel.removeFromSuperview()
                })
            })
        }
    }
}

// MARK:- Regarding UIScrollViewDelegate methods
extension PhotoDetailController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.photoDetailImageView
    }
}
