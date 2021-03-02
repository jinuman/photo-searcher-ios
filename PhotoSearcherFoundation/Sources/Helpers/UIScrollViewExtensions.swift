//
//  UIScrollViewExtensions.swift
//  PhotoSearcherFoundation
//
//  Created by Jinwoo Kim on 2021/03/02.
//

import PhotoSearcherReactive

public extension UIScrollView {
    func isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        guard self.frame.size.height > 0
                && self.contentSize.height > 0 else { return false }

        return self.contentOffset.y
            + self.frame.size.height
            + edgeOffset
            > self.contentSize.height
    }

    func scrollToTop(animated: Bool = true) {
        let topInset = self.contentInset.top
        self.setContentOffset(
            CGPoint(x: 0, y: -topInset),
            animated: animated
        )
    }
}

public extension Reactive where Base: UIScrollView {
    var contentSize: ControlEvent<CGSize> {
        let source = base.rx.observe(CGSize.self, "contentSize")
            .asObservable()
            .compactMap { $0 }
        return ControlEvent(events: source)
    }

    var isNearBottomEdge: ControlEvent<Void> {
        let source: Observable<Void> = base.rx.contentOffset
            .map { [weak base = self.base] _ in
                guard let base = base else { return false }
                return base.isNearBottomEdge()
            }
            .filter { $0 }
            .map { _ in () }
        return ControlEvent(events: source)
    }
}

public extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(
        cellType: T.Type,
        for indexPath: IndexPath
    ) -> T {
        return dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath) as? T ?? T()
    }

    /**
     Multiple `UICollectionViewCell`s can be registered at once.
     */
    func register<T: UICollectionViewCell>(_ cellTypes: [T.Type]) {
        for cellType in cellTypes {
            self.register(
                cellType,
                forCellWithReuseIdentifier: "\(cellType.self)"
            )
        }
    }
}
