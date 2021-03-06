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
    private typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<PhotoSearchViewSection>
    private typealias ConfigureCell = CollectionViewSectionedDataSource<PhotoSearchViewSection>.ConfigureCell

    // MARK: - Module

    struct Dependency {
        let photoDetailViewReactorFactory: PhotoDetailViewReactor.Factory
        let photoDetailViewControllerFactory: PhotoDetailViewController.Factory
    }

    struct Payload {
        let reactor: Reactor
    }


    // MARK: - Properties

    private let dependency: Dependency
    private let payload: Payload
    private lazy var dataSource = self.createDataSource()


    // MARK: - UI

    private let searchBar = UISearchBar().then {
        $0.placeholder = "Please enter keyword.."
        $0.searchBarStyle = .prominent
        $0.barTintColor = .black
        let textFieldInsideSearchBar = $0.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor(red: 240, green: 240, blue: 240)
        textFieldInsideSearchBar?.autocapitalizationType = .none
    }
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.scrollDirection = .vertical
            let width = UIScreen.main.bounds.width - 20
            $0.itemSize = CGSize(width: width, height: width / 1.5)
            $0.minimumLineSpacing = 20
            $0.minimumInteritemSpacing = 0
            $0.sectionInset = UIEdgeInsets(vertical: 10)
        }
    ).then {
        $0.backgroundColor = .black
        $0.register([PhotoItemCollectionViewCell.self])
    }


    // MARK: - Initializing

    init(dependency: Dependency, payload: Payload) {
        defer { self.reactor = payload.reactor }
        self.dependency = dependency
        self.payload = payload
        super.init()
        self.title = "Photo Search"
    }

    private func createDataSource() -> DataSource {
        let configureCell: ConfigureCell = { dataSource, collectionView, indexPath, sectionItem in
            switch sectionItem {
            case let .photoItem(photo):
                let cell = collectionView.dequeueReusableCell(
                    cellType: PhotoItemCollectionViewCell.self,
                    for: indexPath
                )
                cell.configure(with: photo.url)
                return cell
            }
        }
        return DataSource(configureCell: configureCell)
    }


    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorPalette.black
    }


    // MARK: - Binding

    func bind(reactor: Reactor) {
        self.bindRefresh(reactor: reactor)
        self.bindSearch(reactor: reactor)
        self.bindCollectionView(reactor: reactor)
    }

    private func bindRefresh(reactor: Reactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }

    private func bindSearch(reactor: Reactor) {
        self.searchBar.rx.searchButtonClicked
            .withLatestFrom(self.searchBar.rx.text)
            .subscribe(onNext: { [weak self] keyword in
                guard let self = self else { return }
                guard let keyword = keyword?
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                        .replacingOccurrences(of: " ", with: "+"),
                      !keyword.isEmpty else {
                    let alertConfig = AlertConfig(
                        message: "You should enter keyword.",
                        defaultButtonTitle: "OK"
                    )
                    let alertController = UIAlertController.make(with: alertConfig)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                self.reactor?.action.onNext(.searchPhotos(keyword: keyword))
            })
            .disposed(by: self.disposeBag)
    }

    private func bindCollectionView(reactor: Reactor) {
        reactor.state.map { $0.sections }
            .distinctUntilChanged()
            .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)

        reactor.shouldScrollToTop
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.collectionView.scrollToTop()
            })
            .disposed(by: self.disposeBag)

        Observable.zip(
            self.collectionView.rx.itemSelected,
            self.collectionView.rx.modelSelected(PhotoSearchViewSection.Item.self))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] indexPath, sectionItem in
                guard let self = self,
                      case let .photoItem(photo) = sectionItem else { return }
                self.collectionView.deselectItem(at: indexPath, animated: true)
                let reactor = self.dependency.photoDetailViewReactorFactory.create(payload: .init(
                    photo: photo
                ))
                let viewController = self.dependency.photoDetailViewControllerFactory.create(payload: .init(
                    reactor: reactor
                ))
                viewController.title = photo.title
                self.navigationController?.pushViewController(viewController, animated: true)
            })
            .disposed(by: self.disposeBag)
    }


    // MARK: - Layout

    override func configureLayout() {
        self.view.addSubviews([
            self.searchBar,
            self.collectionView
        ])

        self.searchBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(super.guide)
        }
        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalTo(super.guide)
        }
    }
}
