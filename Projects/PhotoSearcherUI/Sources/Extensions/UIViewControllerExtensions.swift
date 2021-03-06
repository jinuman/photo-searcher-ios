//
//  UIViewControllerExtensions.swift
//  PhotoSearcherFoundation
//
//  Created by Jinwoo Kim on 2021/03/02.
//

import PhotoSearcherReactive

public extension UIViewController {
    func deinitLog(_ className: String) {
        #if DEBUG
        print("\n==================================================")
        print("♻️ \(className) deinit ♻️")
        print("==================================================\n")
        #endif
    }
}

public extension Reactive where Base: UIViewController {
    var viewDidLoad: ControlEvent<Void> {
        let source = self
            .methodInvoked(#selector(Base.viewDidLoad))
            .map { _ in () }

        return ControlEvent(events: source)
    }

    var viewWillAppear: ControlEvent<Bool> {
        let source = self
            .methodInvoked(#selector(Base.viewWillAppear))
            .map { $0.first as? Bool ?? false }

        return ControlEvent(events: source)
    }

    var viewDidAppear: ControlEvent<Bool> {
        let source = self
            .methodInvoked(#selector(Base.viewDidAppear))
            .map { $0.first as? Bool ?? false }

        return ControlEvent(events: source)
    }

    var viewWillDisappear: ControlEvent<Bool> {
        let source = self
            .methodInvoked(#selector(Base.viewWillDisappear))
            .map { $0.first as? Bool ?? false }

        return ControlEvent(events: source)
    }
    var viewDidDisappear: ControlEvent<Bool> {
        let source = self
            .methodInvoked(#selector(Base.viewDidDisappear))
            .map { $0.first as? Bool ?? false }

        return ControlEvent(events: source)
    }
    var viewWillLayoutSubviews: ControlEvent<Void> {
        let source = self
            .methodInvoked(#selector(Base.viewWillLayoutSubviews))
            .map { _ in () }

        return ControlEvent(events: source)
    }
    var viewDidLayoutSubviews: ControlEvent<Void> {
        let source = self
            .methodInvoked(#selector(Base.viewDidLayoutSubviews))
            .map { _ in () }

        return ControlEvent(events: source)
    }
}
