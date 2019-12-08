//
//  ErrorHandler.swift
//  NYT
//
//  Created by Rupesh Jaiswal on 8/12/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//

import UIKit

class ErrorHandler {

    class func showError(error: Error?, viewController: UIViewController) {
        guard let error = error else { return }
        
        let errorInfo = error as? ErrorInfo
        guard let title = errorInfo?.title, let description = errorInfo?.description else { return }
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }

    class func showAlert(title: String, description: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
}
