//
//  PhotoSearchViewController.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/03/02.
//

import PhotoSearcherUI
import PhotoSearcherReactive

final class PhotoSearchViewController: BaseViewController, View, FactoryModule {

    internal typealias Reactor = PhotoSearchViewReactor

    // MARK: Module

    struct Dependency {

    }

    struct Payload {
        let reactor: Reactor
    }


    // MARK: Properties

    private let searchBar = UISearchBar().then {
        $0.placeholder = "Please enter keyword.."
        $0.searchBarStyle = .prominent
        $0.barTintColor = .black
        let textFieldInsideSearchBar = $0.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor(r: 240, g: 240, b: 240)
    }
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        $0.backgroundColor = .black
        $0.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCellId")
    }


    // MARK: Initializing

    init(dependency: Dependency, payload: Payload) {
        super.init()
        self.title = "Photo Search"
    }


    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func bind(reactor: Reactor) {
    }


    // MARK: Layout

    override func configureLayout() {
        self.view.addSubview(self.searchBar)

        self.searchBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(super.guide)
        }
    }
}
