//
//  BaseViewController.swift
//  PhotoSearcherUI
//
//  Created by Jinwoo Kim on 2021/03/02.
//

import PhotoSearcherReactive

/// This `BaseViewController` serves as the parent of every UIViewController we will make.
open class BaseViewController: UIViewController {

    // MARK: - Properties

    public lazy var guide = self.view.safeAreaLayoutGuide
    public var disposeBag = DisposeBag()


    // MARK: - Initializing

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required convenience init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        let className = type(of: self).description().components(separatedBy: ".").last ?? "?Unexpected class?"
        self.deinitLog(className)
    }


    // MARK: - View Life Cycle

    open override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }

        self.configureLayout()
    }


    // MARK: - Layout

    /// Override during subclassing to configure Auto Layout Constraints here.
    open func configureLayout() {
      // Override Point
    }
}
