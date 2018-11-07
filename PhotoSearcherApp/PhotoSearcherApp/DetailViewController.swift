//
//  DetailViewController.swift
//  PhotoSearcherApp
//
//  Created by Jinwoo Kim on 2018. 11. 4..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button: UIBarButtonItem!
    
    var url:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = url {
            setImage(url: url)
        }
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 2.0
        scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        button.image = #imageLiteral(resourceName: "baseline_save_white_24pt")
    }
    
    func setImage(url: String) {
        let imageUrl = URL(string: url)
        self.imageView.kf.setImage(with: imageUrl)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let imageToSave = imageView.image else { return }
        let alertController = UIAlertController(title: "Do you want to save photo?",
                                                message: nil,
                                                preferredStyle: .alert)
        let saveAction: UIAlertAction = UIAlertAction(title: "Yes!",
                                                      style: .default) { (_) in
                                                        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "No!",
                                                        style: .cancel,
                                                        handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
