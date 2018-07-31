//
//  UIViewController+Alert.swift
//  News
//
//  Created by Vitaliy Pavlyuk on 7/31/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import UIKit

extension UIViewController {
    func showOkAlert(title: String, message: String?, completion: (() -> Void)? = nil ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
