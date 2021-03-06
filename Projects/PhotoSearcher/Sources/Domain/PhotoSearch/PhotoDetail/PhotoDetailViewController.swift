//
//  PhotoDetailViewController.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/03/04.
//

import PhotoSearcherUI
import PhotoSearcherReactive

final class PhotoDetailViewController: BaseViewController, View, FactoryModule {

    internal typealias Reactor = PhotoDetailViewReactor

    // MARK: - Module

    struct Dependency {
    }

    struct Payload {
        let reactor: Reactor
    }


    // MARK: - Properties

    private let dependency: Dependency
    private let payload: Payload


    // MARK: - UI

    private let saveButtonItem = UIBarButtonItem(
        image: R.image.save_white(),
        style: .plain,
        target: nil,
        action: nil
    )
    private lazy var scrollView = UIScrollView().then {
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        $0.alwaysBounceVertical = false
        $0.alwaysBounceHorizontal = false
        $0.showsVerticalScrollIndicator = true
        $0.showsHorizontalScrollIndicator = true
        $0.autoresizesSubviews = false
        $0.maximumZoomScale = 3.0
        $0.minimumZoomScale = 1.0
        $0.delegate = self
    }
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }


    // MARK: - Initializing

    init(dependency: Dependency, payload: Payload) {
        defer { self.reactor = payload.reactor }
        self.dependency = dependency
        self.payload = payload
        super.init()
        self.title = "Photo Detail"
    }


    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.navigationItem.rightBarButtonItem = self.saveButtonItem
    }


    // MARK: - Binding

    func bind(reactor: Reactor) {
        self.bindPhoto(reactor: reactor)
        self.bindSave()
    }

    private func bindPhoto(reactor: Reactor) {
        reactor.state.map { $0.photoURLString }
            .distinctUntilChanged()
            .subscribe(onNext: {
                if let photoURLString = $0 {
                    self.imageView.loadImageUsingCache(with: photoURLString)
                } else {
                    self.imageView.image = Photo.defaultImage
                }
            })
            .disposed(by: self.disposeBag)
    }

    private func bindSave() {
        self.saveButtonItem.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self,
                      let image = self.imageView.image else { return }
                let alertController = UIAlertController(
                    title: nil,
                    message: "Do you want to save your photos to your iPhone?",
                    preferredStyle: .alert
                )
                let saveAction = UIAlertAction(
                    title: "Save",
                    style: .default
                ) { [weak self] _ in
                    guard let self = self else { return }
                    UIImageWriteToSavedPhotosAlbum(
                        image,
                        self,
                        #selector(self.image),
                        nil
                    )
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

                alertController.addAction(saveAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            })
            .disposed(by: self.disposeBag)
    }

    @objc private func image(_: UIImage, didFinishSavingWithError error: Error?, contextInfo _: UnsafeRawPointer) {
        if let error = error {
            let alertController = UIAlertController(
                title: "SAVE ERROR",
                message: error.localizedDescription,
                preferredStyle: .alert
            )
            self.present(alertController, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    alertController.dismiss(animated: true, completion: nil)
                }
            }
        } else {
            self.saveFeedback()
        }
    }

    private func saveFeedback() {
        let saveLabel = UILabel().then {
            $0.text = "Saved in the Photos app."
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = UIFont.boldFont(ofSize: 18)
            $0.numberOfLines = 0
            $0.backgroundColor = UIColor(white: 0, alpha: 0.3)
        }
        self.view.addSubview(saveLabel)
        saveLabel.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 150, height: 100))
            $0.center.equalToSuperview()
        }
        saveLabel.layer.transform = CATransform3DMakeScale(0, 0, 0)
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: .curveEaseOut,
            animations: {
                saveLabel.layer.transform = CATransform3DMakeScale(1, 1, 1)
            },
            completion: { _ in
                UIView.animate(
                    withDuration: 0.5,
                    delay: 1.25,
                    usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 0.5,
                    options: .curveEaseOut,
                    animations: {
                        saveLabel.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
                        saveLabel.alpha = 0
                    },
                    completion: { _ in
                        saveLabel.removeFromSuperview()
                    }
                )
            }
        )
    }


    // MARK: - Layout

    override func configureLayout() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.imageView)

        self.scrollView.snp.makeConstraints {
            $0.edges.equalTo(super.guide)
        }
        self.imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension PhotoDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
