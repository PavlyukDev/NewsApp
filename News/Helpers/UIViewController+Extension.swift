//
//  UIViewController+Extension.swift
//  News
//
//  Created by Vitaliy Pavlyuk on 7/27/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import UIKit

extension UIViewController {
    class func instantiate<T: UIViewController>(storyboardName: String? = nil, identifier: String? = nil) -> T {
        let className = String.init(describing: T.self)
        let storyboard = UIStoryboard(name: storyboardName ?? className, bundle: Bundle(for: T.self))
        return storyboard.instantiateViewController(withIdentifier: identifier ?? className) as! T
    }
}
