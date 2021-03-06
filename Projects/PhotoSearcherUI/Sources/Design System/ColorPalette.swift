//
//  ColorPalette.swift
//  PhotoSearcher
//
//  Created by Jinwoo Kim on 2021/03/02.
//

public enum ColorPalette {
    public static let clear = UIColor.clear
    public static let white = UIColor.white
    public static let black = UIColor.black

    public static let red = UIColor.systemRed
    public static let orange = UIColor.systemOrange
    public static let yellow = UIColor.systemYellow
    public static let green = UIColor.systemGreen
    public static let blue = UIColor.systemBlue
    public static let purple = UIColor.systemPurple
    public static let teal = UIColor.systemTeal

    public static let lightgray = UIColor.systemGray
}


public extension ColorPalette {
    static let backgroundGray = UIColor(red: 250, green: 250, blue: 250)
    static let separatorGray = UIColor(red: 250, green: 250, blue: 250)
    static let borderGray = UIColor(red: 250, green: 250, blue: 250)

    static let pacificBlue = UIColor(red: 40, green: 104, blue: 207)
    static let lightBlue = UIColor(red: 53, green: 151, blue: 255)
    static let skyblue = UIColor(red: 242, green: 248, blue: 255)
    static let charcoal = UIColor(red: 64, green: 64, blue: 64)
    static let coral = UIColor(red: 255, green: 93, blue: 91)
    static let magenta = UIColor(red: 183, green: 24, blue: 140)
}


// MARK: - iOS 13+ (Dark mode support)

public extension ColorPalette {
    static let indigo = ColorCompatibility.systemIndigo

    static let gray = ColorCompatibility.systemGray3
    static let darkgray = ColorCompatibility.systemGray5

    static let systemBackground = ColorCompatibility.systemBackground
    static let secondarySystemBackground = ColorCompatibility.secondarySystemBackground
    static let tertiarySystemBackground = ColorCompatibility.tertiarySystemBackground

    static let systemGroupedBackground = ColorCompatibility.systemGroupedBackground
    static let secondarySystemGroupedBackground = ColorCompatibility.secondarySystemGroupedBackground
    static let tertiarySystemGroupedBackground = ColorCompatibility.tertiarySystemGroupedBackground

    static let label = ColorCompatibility.label
}
