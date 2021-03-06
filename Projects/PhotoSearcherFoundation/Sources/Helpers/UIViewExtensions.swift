//
//  UIViewExtensions.swift
//  PhotoSearcherFoundation
//
//  Created by Jinwoo Kim on 2021/03/02.
//

public extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach {
            self.addSubview($0)
        }
    }
}
