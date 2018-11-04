//
//  ViewController.swift
//  PhotoSearcherApp
//
//  Created by Jinwoo Kim on 2018. 11. 4..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imagesArray = [NSDictionary]()
    var indexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        search(query: "wave")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "showPhoto":
            let photoVC = segue.destination as? DetailViewController
            photoVC?.url = self.imagesArray[self.indexPath.row]["url"] as? String
        default:
            break
        }
    }
    
    func search(query: String) {
        let searchQuery = query.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "%20")
        let request = Alamofire.request("http://localhost:3000/api/\(searchQuery)",
            method: .get,
            encoding: URLEncoding.default)
        request.responseJSON { response in
            if let JSON = response.result.value {
                print(JSON)
                for photo in JSON as! [AnyObject] {
                    var imageDictionary = [String:String]()
                    imageDictionary["title"] = photo["title"] as? String
                    imageDictionary["source"] = photo["source"] as? String
                    imageDictionary["url"] = photo["url"] as? String
                    self.imagesArray.append(imageDictionary as NSDictionary)
                }
                self.collectionView.reloadData()
            }
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.imagesArray.count > 0 {
            return self.imagesArray.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! SearchCollectionViewCell
        photoCell.url = self.imagesArray[indexPath.row]["url"] as? String
        
        return photoCell
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.indexPath = indexPath
        self.performSegue(withIdentifier: "showPhoto", sender: self)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 2)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.imagesArray = []
        self.collectionView.reloadData()
        if let query = searchBar.text {
            search(query: query)
        }
    }
}
