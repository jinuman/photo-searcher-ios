//
//  FoundationExtensions.swift
//  PhotoSearcherFoundation
//
//  Created by Jinwoo Kim on 2021/03/02.
//

public extension Dictionary {
    static func + (lhs: Dictionary, rhs: Dictionary) -> Dictionary {
        var result = lhs
        rhs.forEach { result[$0.key] = $0.value }
        return result
    }
}

public extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public extension Optional where Wrapped: Swift.Collection {
    var isNilOrEmpty: Bool {
        guard let self = self else { return true }
        return self.isEmpty != false
    }
}
