//
//  UIFontExtensions.swift
//  PhotoSearcherFoundation
//
//  Created by Jinwoo Kim on 2021/03/02.
//

public extension UIFont {
    static func ultraLightFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .ultraLight)
    }

    static func lightFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .light)
    }

    static func regularFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }

    static func mediumFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }

    static func semiboldFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }

    static func boldFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }

    static func blackFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .black)
    }
}

public extension Optional where Wrapped == UIFont {
    var safeUnwrapped: UIFont {
        return self ?? UIFont.systemFont(ofSize: 14)
    }
}
