//
//  UIAlertControllerExtensions.swift
//  PhotoSearcherFoundation
//
//  Created by Jinwoo Kim on 2021/03/06.
//

public struct AlertConfig: Hashable {
    let title: String?
    let message: String?
    let preferredStyle: UIAlertController.Style
    let defaultButtonTitle: String?

    public init(
        title: String? = nil,
        message: String? = nil,
        preferredStyle: UIAlertController.Style = .alert,
        defaultButtonTitle: String? = nil
    ) {
        self.title = title
        self.message = message
        self.preferredStyle = preferredStyle
        self.defaultButtonTitle = defaultButtonTitle
    }
}

public extension UIAlertController {
    static func make(with config: AlertConfig) -> UIAlertController {
        let alertController = UIAlertController(
            title: config.title ?? "",
            message: config.message,
            preferredStyle: config.preferredStyle
        )
        if let defaultButtonTitle = config.defaultButtonTitle {
            let alertAction = UIAlertAction(
                title: defaultButtonTitle,
                style: .default,
                handler: nil
            )
            alertController.addAction(alertAction)
        }
        return alertController
    }
}

